import React, { Component } from 'react'
import PropTypes from 'prop-types'
import { Modal } from '../../../Controls'
import { Button } from '../../../Elements'

export default class Confirm extends Component {
    static propTypes = {
        onClose: PropTypes.func.isRequired,
        onConfirm: PropTypes.func.isRequired,
        item: PropTypes.shape({}),
    };

    static defaultProps = {
        item: {},
    };

    onClose() {
        const { item, onClose } = this.props;

        if (item.onClose) {
            item.onClose();
            onClose(item);
        } else {
            onClose(item);
        }
    }

    onConfirm() {
        const { item, onConfirm } = this.props;

        if (item.onConfirm) {
            item.onConfirm();
            onConfirm(item);
        }
    }

    render() {
        const { item } = this.props;
        const { title, text } = item;

        return (
            <Modal showClose={false}>
                <Modal.Card>
                    <Modal.Card.Head onClose={() => this.onClose()}>
                        <Modal.Card.Title>
                            {title}
                        </Modal.Card.Title>
                    </Modal.Card.Head>
                    <Modal.Card.Body>
                        <p>{text}</p>
                    </Modal.Card.Body>
                    <Modal.Card.Foot>
                        <p>
                            <Button color="info" onClick={() => this.onConfirm()}>Confirm</Button>
                            <Button color="light" onClick={() => this.onClose()}>Close</Button>
                        </p>
                    </Modal.Card.Foot>
                </Modal.Card>
            </Modal>
        );
    }
}
