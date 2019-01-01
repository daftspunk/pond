import React, { PureComponent } from 'react';
import PropTypes from 'prop-types';
import { Field, Control, Label, Input, Help } from '../../../Controls/Form/Form';
import { Modal } from '../../../Controls';
import { Button } from '../../../Elements';

export default class Form extends PureComponent {
    static propTypes = {
        onClose: PropTypes.func,
        onCreateShowSelect: PropTypes.func,
        onCreateProject: PropTypes.func,
    };

    static defaultProps = {
    };

    state = {
        project: {
            name: '',
            directory: '',
            description: '',
        },
        submitted: false
    };

    handleChange = (event) => {
        const { name, value } = event.target;
        const { project } = this.state;
        this.setState({
            project: {
                ...project,
                [name]: value
            }
        });
    }

    handleSubmit = (event) => {
        event.preventDefault();
        this.setState({ submitted: true });

        const { project } = this.state;
        // @todo Validate project
        this.props.onCreateProject(project);
    }

    render() {
        const { onClose, onCreateShowSelect } = this.props;
        return (
            <form name="form" onSubmit={this.handleSubmit}>
                <Modal.Card>
                    <Modal.Card.Head onClose={onClose}>
                        <Modal.Card.Title>
                            Add another project
                        </Modal.Card.Title>
                    </Modal.Card.Head>
                    <Modal.Card.Body>
                        <Field label="Project name">
                            <Input
                                placeholder="Pick a name for this project"
                                name="name"
                                autoFocus
                                onChange={this.handleChange} />
                        </Field>
                        <Field label="Project directory">
                            <Input
                                name="directory"
                                onChange={this.handleChange} />
                        </Field>
                        <Field label="Description">
                            <Input
                                name="description"
                                onChange={this.handleChange} />
                        </Field>

                    </Modal.Card.Body>
                    <Modal.Card.Foot>
                        <p>
                            <Button color="primary">Create</Button>
                        </p>
                        <p>
                            <Button onClick={onCreateShowSelect}>
                                Go Back
                            </Button>
                        </p>
                    </Modal.Card.Foot>
                </Modal.Card>
            </form>
        );
    }
}
