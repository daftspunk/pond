import { PROJECT_CREATE } from '../constants/ModalConstants';
import { onOpenModal } from '../actions/ModalActions';

//
// Actions
//

const CREATE_SELECT = 'october/project/CREATE_SELECT';
const CREATE_FORM = 'october/project/CREATE_FORM';

//
// Reducers
//

export default function reducer(state = {}, action) {
    switch (action.type) {
        case CREATE_SELECT:
            return {
                showSelect: true
            };
        case CREATE_FORM:
            return {
                showForm: true
            };
        default:
            return state;
    }
}

//
// Action Creators
//

export function onCreateProject() {
    return () => alert('hi');
}

export function onCreateProjectModal() {
    return (dispatch) => {
        dispatch(onCreateShowSelect());
        dispatch(onOpenModal({
            type: PROJECT_CREATE,
        }));
    };
}

export function onCreateShowSelect() {
    return { type: CREATE_SELECT };
}

export function onCreateShowForm() {
    return { type: CREATE_FORM };
}
