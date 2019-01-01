import React, { PureComponent } from 'react';
import PropTypes from 'prop-types';
import { Modal } from '../../../Controls';
import { Button } from '../../../Elements';

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
                    <Modal.Card.Title>
                        Add another project
                    </Modal.Card.Title>
                </Modal.Card.Head>
                <Modal.Card.Body>
                    Create or Find
                </Modal.Card.Body>
                <Modal.Card.Foot>
                    <p>
                        <Button color="primary" onClick={onCreateShowForm}>
                            Create Project
                        </Button>
                    </p>
                    <p>
                        <Button>Add Existing</Button>
                    </p>
                </Modal.Card.Foot>
            </Modal.Card>
        );
    }
}
