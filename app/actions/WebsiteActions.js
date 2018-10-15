import { ONLINE, OFFLINE } from '../constants/EnvironmentConstants';

//
// Actions
//

const SET_STATUS = 'october/website/SET_STATUS';
const SET_SELECTED = 'october/website/SET_SELECTED';
const ADD_WEBSITE = 'october/website/ADD_WEBSITE';
const LOG_EVENT = 'october/website/LOG_EVENT';

//
// Reducers
//

export default function reducer(state = {}, action) {
    switch (action.type) {
        // case CREATE_SELECT:
        //     return {
        //         showSelect: true
        //     };
        // case CREATE_FORM:
        //     return {
        //         showForm: true
        //     };
        default:
            return state;
    }
}

//
// Action Creators
//

export function onAddWebsite(website) {
    return {
        type: ADD_WEBSITE,
        website: website
    };
}

export function onSelectWebsite(website) {
    return {
        type: SET_SELECTED,
        website: website
    };
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
