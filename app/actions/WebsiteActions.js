import { CREATE_WEBSITE } from '../constants/SlideConstants'
import { WEBSITE_UPDATE } from '../constants/ModalConstants'
import { onOpenModal, onCloseModal } from '../actions/ModalActions'
import { onOpenSlides, onCloseSlides } from '../actions/SlideActions'
import { SubmissionError } from 'redux-form'
import WebsiteModel from '../models/Website'

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

const SET_ACTIVE_PROJECT = 'october/project/SET_ACTIVE_PROJECT';

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
}

export default function reducer(state = initialState, action) {
    switch (action.type) {
        case SET_ACTIVE_PROJECT:
            return {
                ...state,
                websites: [],
            };
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
