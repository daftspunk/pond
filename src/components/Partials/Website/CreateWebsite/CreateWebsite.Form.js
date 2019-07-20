import React, { Component } from 'react';
import { reduxForm } from 'redux-form';
import PropTypes from 'prop-types';
import { CREATE_WEBSITE_FORM } from '@constants/FormConstants';
import { Form } from '../../../Controls';
import { Field, Control, Input } from '../../../Controls/Form';
import { Button, Level } from '../../../Elements';
import SlideLayout from '../../../Layouts/Slide/Slide';
// import { reset } from 'redux-form'

class CreateWebsiteForm extends Component {
    static propTypes = {
        onCloseSlides: PropTypes.func.isRequired,
        onSetNewWebsite: PropTypes.func.isRequired,
        handleSubmit: PropTypes.func.isRequired,
        project: PropTypes.shape({}),
    };

    static defaultProps = {
        project: {},
    };

    state = {
        isRemoteEnabled: false
    }

    handleSubmit = async (values) => {
        const { onCreateWebsite, onSetNewWebsite, project } = this.props;
        await onCreateWebsite(project, values);
        // reset(CREATE_WEBSITE_FORM);
        // onSetNewWebsite(false);
    }

    handleRemoteToggle = event => {
        this.setState({ isRemoteEnabled: event.target.checked });
    }

    renderPortField = () => {
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
        const { handleSubmit, onCloseSlides, project } = this.props;
        const isRemoteEnabled = !!this.state.isRemoteEnabled;

        return (
            <React.Fragment>
                <SlideLayout.Title title={project.name||'Pond'} subtitle="Create a New Website" />
                <SlideLayout.Content>
                    <Form>
                        <Form.Field name="name" label="Website name" placeholder="Pick a name for your new website" autoFocus />
                        <Form.Field name="folderName" label="Folder name" comment={`Folder will be created in ${project.basePath}`} placeholder="Directory to store the website files" />
                        <Form.Field name="description" label="Description" component="textarea" fullwidth />
                        <Form.Field name="localPort" label="Preferred port number" component={this.renderPortField()} />
                        <Form.EmptyField>
                            <p className="has-text-grey">
                                Pick a preferred port number for your website.
                                If the port is taken a random one will be used instead.
                            </p>
                        </Form.EmptyField>
                        <Form.Field name="isRemoteEnabled" label="Remote Deployments" component="checkbox" onChange={this.handleRemoteToggle} fullwidth />
                        {isRemoteEnabled &&
                            <Form.Field name="remoteHandleshake" placeholder="Paste the remote server's secret handshake here" component="textarea" fullwidth indent />
                        }
                    </Form>
                </SlideLayout.Content>
                <SlideLayout.Buttons>
                    <Level>
                        <Level.Side align="left">
                            <Button color="info" onClick={handleSubmit(this.handleSubmit)}>
                                Continue
                            </Button>
                        </Level.Side>
                        <Level.Side align="right">
                            <Button onClick={onCloseSlides}>
                                Go Back
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
})(CreateWebsiteForm)
