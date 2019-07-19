import { ONLINE, OFFLINE, STARTING, STOPPING } from '../constants/EnvironmentConstants'
import * as Installer from '../services/Provision/Installer'
import * as Logger from '../services/Support/Logger'

//
// API
//

const initialState = {
    status: {},
    logText: {},
    loggers: {},
}

export const ServerActions = {
    onStartServer,
    onStopServer,
}

//
// Actions
//

const START_SERVER_REQUEST = 'october/website/START_SERVER_REQUEST'
const START_SERVER_SUCCESS = 'october/website/START_SERVER_SUCCESS'
const START_SERVER_FAILURE = 'october/website/START_SERVER_FAILURE'

const STOP_SERVER_REQUEST = 'october/website/STOP_SERVER_REQUEST'
const STOP_SERVER_SUCCESS = 'october/website/STOP_SERVER_SUCCESS'
const STOP_SERVER_FAILURE = 'october/website/STOP_SERVER_FAILURE'
const LOG_EVENT = 'october/website/LOG_EVENT'

//
// Reducers
//

export default function reducer(state = initialState, action) {
    const id = action.website && action.website.id;

    switch (action.type) {
        case START_SERVER_REQUEST:
            return {
                ...state,
                status: { ...state.status, [id]: STARTING },
            }
        case START_SERVER_SUCCESS:
            return {
                ...state,
                status: { ...state.status, [id]: ONLINE },
                loggers: { ...state.loggers, [id]: action.logger },
                logText: { ...state.logText, [id]: action.logger.asText() },
            };
        case START_SERVER_FAILURE:
            return {
                ...state,
                status: { ...state.status, [id]: OFFLINE },
            }
        case STOP_SERVER_REQUEST:
            return {
                ...state,
                status: { ...state.status, [id]: STOPPING },
            }
        case STOP_SERVER_SUCCESS:
            if (state.loggers[id]) {
                state.loggers[id].destroy();
            }
            return {
                ...state,
                status: { ...state.status, [id]: OFFLINE },
                loggers: { ...state.loggers, [id]: null },
            }
        case STOP_SERVER_FAILURE:
            return {
                ...state,
                status: { ...state.status, [id]: ONLINE },
            }
        case LOG_EVENT:
            return {
                ...state,
                logText: { ...state.logText, [id]: action.logText },
            }
        default:
            return state;
    }
}

//
// Action Creators
//

export function onStartServer(website) {
    return async dispatch => {
        dispatch(request(website));

        const logger = Logger.newLogger();

        logger.on('log', message => {
            dispatch(log(website, logger.asText()));
        });

        try {
            await website.startServer(logger);
            dispatch(success(website, logger));
        }
        catch (err) {
            dispatch(failure(website, err.toString()));
        }
    }

    function request(website) { return { type: START_SERVER_REQUEST, website } }
    function success(website, logger) { return { type: START_SERVER_SUCCESS, website, logger } }
    function failure(website, error) { return { type: START_SERVER_FAILURE, website, error } }
    function log(website, logText) { return { type: LOG_EVENT, website, logText } }
}

export function onStopServer(website) {
    return async dispatch => {
        dispatch(request(website));

        try {
            await website.stopServer();
            dispatch(success(website));
        }
        catch (err) {
            dispatch(failure(website, err.toString()));
        }
    }

    function request(website) { return { type: STOP_SERVER_REQUEST, website } }
    function success(website) { return { type: STOP_SERVER_SUCCESS, website } }
    function failure(website, error) { return { type: STOP_SERVER_FAILURE, website, error } }
}
