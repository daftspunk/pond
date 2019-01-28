import { ONLINE, OFFLINE } from '../constants/EnvironmentConstants'
import { CREATE_WEBSITE } from '../constants/SlideConstants'
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

const SET_STATUS = 'october/website/SET_STATUS';

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
    editWebsite: null
}

export default function reducer(state = initialState, action) {
    switch (action.type) {
        case FETCH_WEBSITES_SUCCESS:
            return {
                ...state,
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
    onSetNewWebsite,
    onFetchWebsites,
    onCreateWebsite,
    onServerStarted,
    onServerStopped,
    onLogMessage,
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

export function onFetchWebsites() {
    return async (dispatch) => {
        const websites = await (new WebsiteModel).get()

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

        const fullPath = await website.fullPath();

        let err = Installer.canDeploy(fullPath);
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
            await Installer.deployInstaller(logger, fullPath);

            await website.save();

            dispatch(success(website));
        }
        catch (err) {
            dispatch(failure(err.toString()));
        }
    };

    function request(website) { return { type: CREATE_REQUEST, website } }
    function success(website) { return { type: CREATE_SUCCESS, website } }
    function failure(error) { return { type: CREATE_FAILURE, error } }
    function progress(step) { return { type: CREATE_PROGRESS, step } }
    function log(logText) { return { type: CREATE_LOG_TEXT, logText } }
}

export function onServerStarted(website) {
    return {
        type: SET_STATUS,
        websiteId: website._id,
        status: ONLINE
    };
}

export function onServerStopped(website) {
    return {
        type: SET_STATUS,
        websiteId: website._id,
        status: ONLINE
    };
}

export function onLogMessage(website, message) {
    return {
        type: LOG_EVENT,
        websiteId: website._id,
        message: message
    };
}
