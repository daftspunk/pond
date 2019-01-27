import { PROJECT_CREATE } from '../constants/ModalConstants'
import { onOpenModal } from '../actions/ModalActions'
import { createScanner } from '../services/Initializer/InitializerFactory'
import { getDistDir } from '../utils/assets'

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

export const ProjectActions = {
    onCreateProject,
    onCreateProjectModal,
    onCreateShowSelect,
    onCreateShowForm
}

export function onCreateProject() {
    return (dispatch) => { };
    // return async (dispatch) => {
    //     let project = {
    //         location: getDistDir() + '/../'
    //     };
    //     console.log(project);

    //     let scanner = createScanner(project);
    //     const test = await scanner.run();
    //     console.log(test);
    // };
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
