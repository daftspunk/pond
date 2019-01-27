import React, { Component } from 'react'
import { reduxForm } from 'redux-form'
import PropTypes from 'prop-types'
import { Form } from '../../../Controls'
import { Field, Control, Input } from '../../../Controls/Form'
import { Button, Level } from '../../../Elements'
import SlideLayout from '../../../Layouts/SlideLayout/SlideLayout'
import { CREATE_WEBSITE_FORM } from '../../../../constants/FormConstants'

class CreateProjectForm extends Component {
    static propTypes = {
        onCloseSlides: PropTypes.func,
    };

    static defaultProps = {
    };

    state = {
        isRemoteEnabled: false
    }

    handleRemoteToggle = event => {
        this.setState({ isRemoteEnabled: event.target.checked });
    }

    renderPortField() {
        return props => (
            <Field kind="addons">
                <Control>
                    <Button isStatic>http://localhost</Button>
                </Control>
                <Control fullwidth>
                    <Input {...props} />
                </Control>
            </Field>
        )
    }

    render() {
        const { onCloseSlides } = this.props;
        const isRemoteEnabled = !!this.state.isRemoteEnabled;

        return (
            <React.Fragment>
                <SlideLayout.Title title="The Pond" subtitle="Create a new website" />
                <SlideLayout.Content>
                    <Form>
                        <Form.Field name="name" label="Website name" placeholder="Pick a name for your new website" autoFocus />
                        <Form.Field name="folder_name" label="Folder name" placeholder="Directory to store the website files" />
                        <Form.Field name="description" label="Description" fullwidth />
                        <Form.Field name="port" label="Port" component={this.renderPortField()} />
                        <Form.EmptyField>
                            <p className="has-text-grey">
                                Pick a preferred port number for your website.
                                If the port is taken a random one will be used instead.
                            </p>
                        </Form.EmptyField>
                        <Form.Field name="is_remote_enabled" label="Remote Deployments" component="checkbox" onChange={this.handleRemoteToggle} fullwidth />
                        {isRemoteEnabled &&
                            <Form.Field name="remote_handleshake" placeholder="Paste the remote server's secret handshake here" component="textarea" fullwidth indent />
                        }
                    </Form>
                </SlideLayout.Content>
                <SlideLayout.Buttons>
                    <Level>
                        <Level.Side align="left">
                            <Button onClick={onCloseSlides}>
                                Go Back
                            </Button>
                        </Level.Side>
                        <Level.Side align="right">
                            <Button color="info" onSubmit={onCloseSlides}>
                                Create
                            </Button>
                        </Level.Side>
                    </Level>
                </SlideLayout.Buttons>
            </React.Fragment>
        )
    }
}

export default reduxForm({
    form: CREATE_WEBSITE_FORM
})(CreateProjectForm)
