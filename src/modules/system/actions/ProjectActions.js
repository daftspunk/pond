import { PROJECT_CREATE } from '@constants/ModalConstants';
import { onOpenModal, onCloseModal } from '@modules/system/actions/ModalActions';
import { SubmissionError } from 'redux-form';
import ProjectModel from '@modules/system/models/Project';

//
// API
//

const initialState = {
    newProject: false,
    projects: [],
    project: null
};

export const ProjectActions = {
    onFetchProjects,
    onCreateProject,
    onSetActiveProject,
    onSetNewProject
};

//
// Actions
//

const FETCH_PROJECTS_SUCCESS = 'october/project/FETCH_PROJECTS_SUCCESS';

const SET_PROJECT_NEW = 'october/project/SET_PROJECT_NEW';

const SET_ACTIVE_PROJECT = 'october/project/SET_ACTIVE_PROJECT';

const CREATE_SUCCESS = 'october/project/CREATE_SUCCESS';

//
// Reducers
//

export default function reducer(state = initialState, action) {
    switch (action.type) {
        case FETCH_PROJECTS_SUCCESS:
            // If no selected project is found, use the first available
            const project = state.project || action.projects && action.projects[0] || null;
            return {
                ...state,
                projects: action.projects
            };
        case SET_PROJECT_NEW:
            return {
                ...state,
                newProject: action.flag,
            };
        case SET_ACTIVE_PROJECT:
            return {
                ...state,
                project: action.project,
            };
        case CREATE_SUCCESS:
            return {
                ...state,
                projects: [...state.projects, action.project]
            }
        default:
            return state;
    }
}

//
// Action Creators
//

export function onSetActiveProject(project=null) {
    return async (dispatch) => {
        if (!project) {
            project = await (new ProjectModel).first();
        }

        dispatch({ type: SET_ACTIVE_PROJECT, project });
        return project;
    }
}

export function onSetNewProject(flag=true) {
    return (dispatch) => {
        if (flag) {
            dispatch(onOpenModal({ type: PROJECT_CREATE }));
        }
        else {
            dispatch(onCloseModal({ type: PROJECT_CREATE }));
        }

        dispatch({ type: SET_PROJECT_NEW, flag });
    }
}

export function onFetchProjects() {
    return async (dispatch) => {
        const projects = await (new ProjectModel).get()

        // No projects exist so create a new one
        if (projects.length == 0) {
            const newProject = ProjectModel.newDefaultProject();
            await newProject.save();
            projects.push(newProject);
            dispatch(onSetActiveProject(newProject));
        }

        dispatch(success(projects));
    };

    function success(projects) { return { type: FETCH_PROJECTS_SUCCESS, projects } }
}

export function onCreateProject(values) {
    return (dispatch) => {
        if (!values.name) {
            throw new SubmissionError({ name: "Required" });
        }
        if (!values.directory || !values.directory.length) {
            throw new SubmissionError({ directory: "Required" });
        }

        const project = new ProjectModel;
        project.name = values.name;
        project.basePath = values.directory[0].path;
        project.description = values.description;
        project.icon = values.icon;
        project.save();

        dispatch(success(project));
    };

    function success(project) { return { type: CREATE_SUCCESS, project } }
}
