import { ONLINE, OFFLINE } from '../constants/EnvironmentConstants'
import { CREATE_WEBSITE } from '../constants/SlideConstants'
import { onOpenSlides, onCloseSlides } from '../actions/SlideActions'
import { SubmissionError } from 'redux-form'
import WebsiteModel from '../models/Website'

import * as Installer from '../services/Provision/Installer'

//
// Actions
//

const FETCH_WEBSITES_SUCCESS = 'october/website/FETCH_WEBSITES_SUCCESS';

const SET_WEBSITE_NEW = 'october/website/SET_WEBSITE_NEW';

const SET_WEBSITE_EDIT = 'october/website/SET_WEBSITE_EDIT';

const CREATE_SUCCESS = 'october/website/CREATE_SUCCESS';

const SET_STATUS = 'october/website/SET_STATUS';

const LOG_EVENT = 'october/website/LOG_EVENT';

//
// Reducers
//

const initialState = {
    newWebsite: false,
    websites: [],
    editWebsite: null
}

export default function reducer(state = initialState, action) {
    switch (action.type) {
        case SET_WEBSITE_NEW:
            return {
                ...state,
                newWebsite: action.flag,
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
    return { type: SET_WEBSITES_EDIT, website }
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

export function onCreateWebsite(values) {
    return async (dispatch) => {
        if (!values.name) {
            throw new SubmissionError({ name: "Required" });
        }
        if (!values.folderName) {
            throw new SubmissionError({ folderName: "Required" });
        }

        // var webPath = '/mnt/c/some/path';

        // await Installer.deployInstaller(webPath);

        // dispatch(success(website));
    };

    function success(website) { return { type: CREATE_SUCCESS, website } }
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
