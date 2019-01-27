import React, { Component } from 'react';
import PropTypes from 'prop-types';
import { bindActionCreators } from 'redux';
import { connect } from 'react-redux';
import { Modal } from '../../../Controls';
import { Button } from '../../../Elements';
import ProjectSelect from './CreateProject.Select';
import ProjectForm from './CreateProject.Form';
import { ProjectActions } from '../../../../actions/ProjectActions';

class CreateProject extends Component {
    static propTypes = {
        item: PropTypes.object,
        showSelect: PropTypes.bool,
        showForm: PropTypes.bool,
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
                    {this.props.showSelect && (
                        <ProjectSelect {...this.props} onClose={this.onClose} />
                    )}
                    {this.props.showForm && (
                        <ProjectForm {...this.props} onClose={this.onClose} />
                    )}
                </Modal>
            </React.Fragment>
        )
    }
}

export default connect(
    state => ({
        showSelect: state.project.showSelect,
        showForm: state.project.showForm,
    }),
    dispatch => bindActionCreators({
        ...ProjectActions
    }, dispatch)
)(CreateProject)
