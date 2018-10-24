import React, { PureComponent } from 'react';
import PropTypes from 'prop-types';
import { Modal } from '../../../Controls';
import { Columns, Button } from '../../../Elements';

export default class Select extends PureComponent {
    static propTypes = {
        onClose: PropTypes.func,
        onCreateShowForm: PropTypes.func,
    };

    static defaultProps = {
    };

    render() {
        const { onClose, onCreateShowForm } = this.props;
        return (
            <Modal.Card>
                <Modal.Card.Head onClose={onClose}>
                    <Modal.Card.Title className="has-text-centered">
                        Add Project Folder
                    </Modal.Card.Title>
                </Modal.Card.Head>
                <Modal.Card.Body>
                    <Columns>
                        <Columns.Column size={6}>
                            <div className="has-text-centered">
                                <h5 className="title is-5">Create</h5>
                                <p>Create an empty project folder to store your websites.</p>
                                <hr />
                                <Button color="primary" onClick={onCreateShowForm}>
                                    Create Project
                                </Button>
                            </div>
                        </Columns.Column>
                        <Columns.Column size={6}>
                            <div className="has-text-centered">
                                <h5 className="title is-5">Find</h5>
                                <p>Browse for an existing project folder and scan for websites.</p>
                                <hr />
                                <Button>Add Existing</Button>
                            </div>
                        </Columns.Column>
                    </Columns>
                </Modal.Card.Body>
                <Modal.Card.Foot>
                </Modal.Card.Foot>
            </Modal.Card>
        );
    }
}
