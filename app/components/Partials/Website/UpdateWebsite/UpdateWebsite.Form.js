import React, { PureComponent } from 'react'
import { reduxForm } from 'redux-form'
import PropTypes from 'prop-types'
import { Form, Modal } from '../../../Controls'
import { Button, Level } from '../../../Elements'
import { UPDATE_WEBSITE_FORM } from '../../../../constants/FormConstants'
import { reset } from 'redux-form'

class UpdateWebsiteForm extends PureComponent {
    static propTypes = {
        onClose: PropTypes.func,
        onUpdateWebsite: PropTypes.func,
    };

    static defaultProps = {
    };

    state = {
        isRemoteEnabled: false
    }

    handleSubmit = async (values) => {
        const { editWebsite, onUpdateWebsite, onSetEditWebsiteModal } = this.props;
        await onUpdateWebsite(editWebsite, values);
        reset(UPDATE_WEBSITE_FORM);
        onSetEditWebsiteModal(false);
    }

    handleRemoteToggle = event => {
        this.setState({ isRemoteEnabled: event.target.checked });
    }

    render() {
        const { onClose, handleSubmit, onSetEditWebsiteModal } = this.props;
        const isRemoteEnabled = !!this.state.isRemoteEnabled;

        return (
            <Modal.Card>
                <Modal.Card.Head onClose={onClose}>
                    <Modal.Card.Title>
                        Update Website
                    </Modal.Card.Title>
                </Modal.Card.Head>
                <Modal.Card.Body>
                    <Form>
                        <Form.Field name="name" label="Website name" placeholder="Pick a name for your new website" autoFocus />
                        <Form.Field name="folderName" label="Folder name" disabled />
                        <Form.Field name="description" label="Description" component="textarea" fullwidth />
                        <Form.Field name="localPort" label="Preferred port number" />
                        <Form.EmptyField />
                        <Form.Field name="isRemoteEnabled" label="Remote Deployments" component="checkbox" onChange={this.handleRemoteToggle} fullwidth />
                        {isRemoteEnabled &&
                            <Form.Field name="remoteHandleshake" placeholder="Paste the remote server's secret handshake here" component="textarea" fullwidth indent />
                        }
                    </Form>
                </Modal.Card.Body>
                <Modal.Card.Foot>
                    <Button onClick={()=>onSetEditWebsiteModal(false)}>
                        Cancel
                    </Button>
                    <Button color="info" onClick={handleSubmit(this.handleSubmit)}>
                        Update Website
                    </Button>
                </Modal.Card.Foot>
            </Modal.Card>
        )
    }
}

export default reduxForm({
    form: UPDATE_WEBSITE_FORM
})(UpdateWebsiteForm)
