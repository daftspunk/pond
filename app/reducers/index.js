import { combineReducers } from 'redux'
import { routerReducer as router } from 'react-router-redux'
import modals from '../actions/ModalActions'
import project from '../actions/ProjectActions'
import slide from '../actions/SlideActions'
import website from '../actions/WebsiteActions'
import { reducer as formReducer } from 'redux-form'

const rootReducer = combineReducers({
    project,
    modals,
    slide,
    form: formReducer,
    router
})

export default rootReducer
