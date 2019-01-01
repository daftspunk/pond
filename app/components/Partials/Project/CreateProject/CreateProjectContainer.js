import React, { Component } from 'react';
import { bindActionCreators } from 'redux';
import { connect } from 'react-redux';
import CreateProject from './CreateProject';
import {
    onCreateShowSelect,
    onCreateShowForm,
    onCreateProject
} from '../../../../actions/ProjectActions';

const CreateProjectContainer = props => <CreateProject {...props} />;

function mapStateToProps(state) {
    return {
        showSelect: state.project.showSelect,
        showForm: state.project.showForm,
    };
}

function mapDispatchToProps(dispatch) {
    return bindActionCreators({
        onCreateShowSelect,
        onCreateShowForm,
        onCreateProject
    }, dispatch)
}

export default connect(
    mapStateToProps,
    mapDispatchToProps
)(CreateProjectContainer);
