import React, { PureComponent } from 'react';
import { reduxForm } from 'redux-form';
import PropTypes from 'prop-types';
import { CREATE_PROJECT_FORM } from '@constants/FormConstants';
import { Form, Modal } from '../../../Controls';
import { Button, Level } from '../../../Elements';
import { reset } from 'redux-form';

class CreateProjectForm extends PureComponent {
    static propTypes = {
        onClose: PropTypes.func,
        onCreateProject: PropTypes.func,
    };

    static defaultProps = {
    }

    handleSubmit = async (values) => {
        const { onCreateProject, onSetNewProject } = this.props;
        await onCreateProject(values);
        reset(CREATE_PROJECT_FORM);
        onSetNewProject(false);
    }

    render() {
        const { onClose, handleSubmit, onCreateProject, onSetNewProject } = this.props;

        return (
            <Modal.Card>
                <Modal.Card.Head onClose={onClose}>
                    <Modal.Card.Title>
                        Add another project
                    </Modal.Card.Title>
                </Modal.Card.Head>
                <Modal.Card.Body>
                    <Form>
                        <Form.Field name="name" label="Project name" placeholder="Pick a name for this project" rules="required" autoFocus fullwidth />
                        <Form.Field name="directory" label="Project directory" component="fileupload" fullwidth directory />
                        <Form.Field name="description" label="Description" component="textarea" fullwidth />
                        <Form.Field name="icon" label="Icon" component="text" fullwidth />
                    </Form>
                </Modal.Card.Body>
                <Modal.Card.Foot>
                    <Button onClick={()=>onSetNewProject(false)}>
                        Cancel
                    </Button>
                    <Button color="info" onClick={handleSubmit(this.handleSubmit)}>
                        Create Project
                    </Button>
                </Modal.Card.Foot>
            </Modal.Card>
        )
    }
}

export default reduxForm({
    form: CREATE_PROJECT_FORM
})(CreateProjectForm)
