import React, { Component } from 'react';
import PropTypes from 'prop-types';
import { bindActionCreators } from 'redux';
import { connect } from 'react-redux';
import { ProjectActions } from '@modules/system/actions/ProjectActions';
import { Modal } from '../../../Controls';
import { Button } from '../../../Elements';
import ProjectForm from './CreateProject.Form';

class CreateProject extends Component {
    static propTypes = {
        item: PropTypes.object,
    };

    static defaultProps = {
    }

    onClose = () => {
        if (this.props.item.onClose) {
            this.props.item.onClose()
        }

        this.props.onClose(this.props.item)
    }

    render() {
        return (
            <React.Fragment>
                <Modal showClose={false} onClose={this.props.onClose}>
                    <ProjectForm {...this.props} onClose={this.onClose} />
                </Modal>
            </React.Fragment>
        )
    }
}

export default connect(
    state => ({
        newProject: state.project.newProject,
    }),
    dispatch => bindActionCreators({
        ...ProjectActions
    }, dispatch)
)(CreateProject)
