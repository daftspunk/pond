import { ONLINE, OFFLINE, STARTING, STOPPING } from '../constants/EnvironmentConstants'
import { CREATE_WEBSITE } from '../constants/SlideConstants'
import { WEBSITE_UPDATE } from '../constants/ModalConstants'
import { onOpenModal, onCloseModal } from '../actions/ModalActions'
import { onOpenSlides, onCloseSlides } from '../actions/SlideActions'
import { SubmissionError } from 'redux-form'
import WebsiteModel from '../models/Website'

import * as Installer from '../services/Provision/Installer'
import * as Logger from '../services/Support/Logger'

//
// Actions
//

const FETCH_WEBSITES_SUCCESS = 'october/website/FETCH_WEBSITES_SUCCESS';

const SET_WEBSITE_NEW = 'october/website/SET_WEBSITE_NEW';

const SET_WEBSITE_EDIT = 'october/website/SET_WEBSITE_EDIT';

const CREATE_REQUEST = 'october/website/CREATE_REQUEST';
const CREATE_SUCCESS = 'october/website/CREATE_SUCCESS';
const CREATE_FAILURE = 'october/website/CREATE_FAILURE';
const CREATE_PROGRESS = 'october/website/CREATE_PROGRESS';
const CREATE_LOG_TEXT = 'october/website/CREATE_LOG_TEXT';

const UPDATE_SUCCESS = 'october/website/UPDATE_SUCCESS';

const START_SERVER_REQUEST = 'october/website/START_SERVER_REQUEST';
const START_SERVER_SUCCESS = 'october/website/START_SERVER_SUCCESS';
const START_SERVER_FAILURE = 'october/website/START_SERVER_FAILURE';

const STOP_SERVER_REQUEST = 'october/website/STOP_SERVER_REQUEST';
const STOP_SERVER_SUCCESS = 'october/website/STOP_SERVER_SUCCESS';
const STOP_SERVER_FAILURE = 'october/website/STOP_SERVER_FAILURE';
const LOG_EVENT = 'october/website/LOG_EVENT';

//
// Reducers
//

const initialState = {
    newWebsite: false,
    newWebsiteLoading: false,
    newWebsiteStep: 0,
    newWebsiteLogText: "",
    websites: [],
    editWebsite: null,
    editWebsiteLoading: OFFLINE,
    editWebsiteLogText: "",
    editWebsiteLogger: null,
}

export default function reducer(state = initialState, action) {
    switch (action.type) {
        case FETCH_WEBSITES_SUCCESS:
            // If no edit website is found, use the first available
            const editWebsite = state.editWebsite || action.websites && action.websites[0] || null;
            return {
                ...state,
                editWebsite,
                websites: action.websites,
            };
        case CREATE_LOG_TEXT:
            return {
                ...state,
                newWebsiteLogText: action.logText,
            };
        case CREATE_PROGRESS:
            return {
                ...state,
                newWebsiteStep: action.step,
            };
        case CREATE_REQUEST:
            return {
                ...state,
                newWebsiteLoading: true
            };
        case CREATE_FAILURE:
            return {
                ...state,
                newWebsiteLoading: false
            };
        case CREATE_SUCCESS:
            return {
                ...state,
                newWebsite: false,
                newWebsiteLoading: false
            };
        case SET_WEBSITE_NEW:
            return {
                ...state,
                newWebsite: action.flag,
                newWebsiteLoading: false
            };
        case UPDATE_SUCCESS:
        case SET_WEBSITE_EDIT:
            return {
                ...state,
                editWebsite: action.website,
            };
        case START_SERVER_REQUEST:
            return {
                ...state,
                editWebsiteLoading: STARTING,
            }
        case START_SERVER_SUCCESS:
            return {
                ...state,
                editWebsiteLoading: ONLINE,
                editWebsiteLogger: action.logger,
                editWebsiteLogText: action.logger.asText()
            };
        case START_SERVER_FAILURE:
            return {
                ...state,
                editWebsiteLoading: OFFLINE,
            }
        case STOP_SERVER_REQUEST:
            return {
                ...state,
                editWebsiteLoading: STOPPING,
            }
        case STOP_SERVER_SUCCESS:
            if (state.editWebsiteLogger) {
                state.editWebsiteLogger.destroy();
            }
            return {
                ...state,
                editWebsiteLoading: OFFLINE,
                editWebsiteLogger: null,
            }
        case STOP_SERVER_FAILURE:
            return {
                ...state,
                editWebsiteLoading: ONLINE,
            }
        case LOG_EVENT:
            return {
                ...state,
                editWebsiteLogText: action.logText
            }
        default:
            return state;
    }
}

//
// Action Creators
//

export const WebsiteActions = {
    onSetEditWebsite,
    onSetEditWebsiteModal,
    onSetNewWebsite,
    onFetchWebsites,
    onCreateWebsite,
    onUpdateWebsite,
    onStartServer,
    onStopServer,
}

export function onSetEditWebsite(website) {
    return { type: SET_WEBSITE_EDIT, website }
}

export function onSetNewWebsite(flag=true) {
    return (dispatch) => {
        if (flag) {
            dispatch(onOpenSlides(CREATE_WEBSITE));
        }
        else {
            dispatch(onCloseSlides(CREATE_WEBSITE));
        }

        dispatch({ type: SET_WEBSITE_NEW, flag });
    }
}

export function onSetEditWebsiteModal(flag=true) {
    return (dispatch) => {
        if (flag) {
            dispatch(onOpenModal({ type: WEBSITE_UPDATE }));
        }
        else {
            dispatch(onCloseModal({ type: WEBSITE_UPDATE }));
        }
    }
}

export function onFetchWebsites(projectId) {
    return async (dispatch) => {
        const websites = await (new WebsiteModel).where('projectId', projectId).get();

        dispatch(success(websites));
    };

    function success(websites) { return { type: FETCH_WEBSITES_SUCCESS, websites } }
}

export function onCreateWebsite(project, values) {
    return async (dispatch) => {
        if (!values.name) {
            throw new SubmissionError({ name: "Required" });
        }
        if (!values.folderName) {
            throw new SubmissionError({ folderName: "Required" });
        }

        const website = new WebsiteModel;
        website.projectId = project.id;
        website.fill(values);
        website.fullPath = await website.makeFullPath();

        let err = Installer.canDeploy(website.fullPath);
        if (err != null) {
            throw new SubmissionError({ folderName: err.toString() });
        }

        dispatch(request(values));

        const logger = Logger.newLogger();

        logger.on('progress', stepIndex => {
            dispatch(progress(stepIndex));
        });
        logger.on('log', message => {
            dispatch(log(logger.asText()));
        });

        try {
            await Installer.deployInstaller(logger, website.fullPath);

            await website.save();

            dispatch(success(website));
        }
        catch (err) {
            dispatch(failure(err.toString()));
        }
        finally {
            logger.destroy();
            logger = null;
        }
    };

    function request(website) { return { type: CREATE_REQUEST, website } }
    function success(website) { return { type: CREATE_SUCCESS, website } }
    function failure(error) { return { type: CREATE_FAILURE, error } }
    function progress(step) { return { type: CREATE_PROGRESS, step } }
    function log(logText) { return { type: CREATE_LOG_TEXT, logText } }
}

export function onUpdateWebsite(website, values) {
    return async dispatch => {
        try {
            website.fill(values);
            website.fullPath = await website.makeFullPath();
            await website.save();
            dispatch(success(website));
            dispatch(onFetchWebsites(website.projectId));
            return website;
        }
        catch (error) {
            return Promise.reject(error);
        }
    }

    function success(website) { return { type: UPDATE_SUCCESS, website } }
}

export function onStartServer(website) {
    return async dispatch => {
        dispatch(request(website));

        const logger = Logger.newLogger();

        logger.on('log', message => {
            dispatch(log(logger.asText()));
        });

        try {
            await website.startServer(logger);
            dispatch(success(logger));
        }
        catch (err) {
            dispatch(failure(err.toString()));
        }
    }

    function request(website) { return { type: START_SERVER_REQUEST, website } }
    function success(logger) { return { type: START_SERVER_SUCCESS, logger } }
    function failure(error) { return { type: START_SERVER_FAILURE, error } }
    function log(logText) { return { type: LOG_EVENT, logText } }
}

export function onStopServer(website) {
    return async dispatch => {
        dispatch(request(website));

        try {
            await website.stopServer();
            dispatch(success(website));
        }
        catch (err) {
            dispatch(failure(err.toString()));
        }
    }

    function request(website) { return { type: STOP_SERVER_REQUEST, website } }
    function success(website) { return { type: STOP_SERVER_SUCCESS, website } }
    function failure(error) { return { type: STOP_SERVER_FAILURE, error } }
}
