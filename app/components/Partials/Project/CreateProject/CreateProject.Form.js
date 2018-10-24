import React, { PureComponent } from 'react'
import { reduxForm } from 'redux-form'
import PropTypes from 'prop-types'
import { Form, Modal } from '../../../Controls'
import { Button } from '../../../Elements'
import { CREATE_PROJECT_FORM } from '../../../../constants/FormConstants'

class CreateProjectForm extends PureComponent {
    static propTypes = {
        onClose: PropTypes.func,
        onCreateShowSelect: PropTypes.func,
        onCreateProject: PropTypes.func,
    }

    static defaultProps = {
    }

    render() {
        const { onClose, handleSubmit, onCreateProject, onCreateShowSelect } = this.props
        return (
            <Form>
                <Modal.Card>
                    <Modal.Card.Head onClose={onClose}>
                        <Modal.Card.Title>
                            Add another project
                        </Modal.Card.Title>
                    </Modal.Card.Head>
                    <Modal.Card.Body>
                        <Form.Field name="name" label="Project name" placeholder="Pick a name for this project" autoFocus />
                        <Form.Field name="directory" label="Project directory" />
                        <Form.Field name="description" label="Description" />
                    </Modal.Card.Body>
                    <Modal.Card.Foot>
                        <p>
                            <Button color="primary" onSubmit={handleSubmit(onCreateProject)}>Create</Button>
                        </p>
                        <p>
                            <Button onClick={onCreateShowSelect}>
                                Go Back
                            </Button>
                        </p>
                    </Modal.Card.Foot>
                </Modal.Card>
            </Form>
        )
    }
}

export default reduxForm({
    form: CREATE_PROJECT_FORM
})(CreateProjectForm)
