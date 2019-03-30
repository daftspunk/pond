import uuid from 'uuid'
import { ALERT, CONFIRM } from '../constants/ModalConstants'

//
// API
//

const initialState = {
    modals: [],
}

export const ModalActions = {
    onOpenAlert,
    onOpenConfirm,
    onOpenModal,
    onCloseModal
}

//
// Actions
//

const OPEN_MODAL = 'october/modal/OPEN_MODAL'
const CLOSE_MODAL = 'october/modal/CLOSE_MODAL'
const CLOSE_MODAL_BY_TYPE = 'october/modal/CLOSE_MODAL_BY_TYPE'

//
// Reducers
//

export default function reducer(state = initialState, action) {
    switch (action.type) {
        case OPEN_MODAL:
            return {
                ...state,
                modals: state.modals.concat(action.obj)
            };
        case CLOSE_MODAL:
            return {
                ...state,
                modals: state.modals.filter(item => item.id !== action.obj.id),
            };
        case CLOSE_MODAL_BY_TYPE:
            return {
                ...state,
                modals: state.modals.filter(item => item.type !== action.obj.type),
            };
        default:
            return state;
    }
}

//
// Action Creators
//

/*
function onConfirmAction() {
    return (dispatch) => {
        dispatch(onOpenModal({
            id: uuid.v4(),
            type: CONFIRM,
            title: 'Confirm',
            text: 'Are you sure to do this?',
            onClose: () => console.log("fire at closing event"),
            onConfirm: () => console.log("fire at confirming event"),
        }));
    };
}
*/

export function onOpenAlert(text, obj = {}) {
    return onOpenModal({
        type: ALERT,
        title: 'Alert',
        text,
        ...obj
    });
}

export function onOpenConfirm(text, obj = {}) {
    return onOpenModal({
        type: CONFIRM,
        title: 'Confirm',
        text,
        ...obj
    });
}

export function onOpenModal(obj) {
    if (!obj.id) {
        obj.id = uuid.v4();
    }

    return { type: OPEN_MODAL, obj };
}

export function onCloseModal(obj) {
    if (!obj.id) {
        return { type: CLOSE_MODAL_BY_TYPE, obj };
    }

    return { type: CLOSE_MODAL, obj };
}
