import React, { Component } from 'react'
import { bindActionCreators } from 'redux'
import { connect } from 'react-redux'
import CreateProject from './CreateProject'
import {
    onCreateShowSelect,
    onCreateShowForm,
    onCreateProject
} from '../../../../actions/ProjectActions'

const CreateProjectContainer = props => <CreateProject {...props} />

export default connect(
    state => {
        return {
            showSelect: state.project.showSelect,
            showForm: state.project.showForm,
        }
    },
    dispatch => {
        return bindActionCreators({
            onCreateShowSelect,
            onCreateShowForm,
            onCreateProject
        }, dispatch)
    }
)(CreateProjectContainer)
