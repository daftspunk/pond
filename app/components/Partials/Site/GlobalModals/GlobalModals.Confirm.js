import React, { Component } from 'react';
import PropTypes from 'prop-types';
import { Modal } from '../../../Controls';
import { Button } from '../../../Elements';

export default class Confirm extends Component {
    static propTypes = {
        item: PropTypes.object,
    };

    static defaultProps = {
        item: {},
    };

    onClose() {
        if (this.props.item.onClose) {
            this.props.item.onClose();
            this.props.onClose(this.props.item);
        } else {
            this.props.onClose(this.props.item);
        }
    }

    onConfirm() {
        if (this.props.item.onConfirm) {
            this.props.item.onConfirm();
            this.props.onClose(this.props.item);
        }
    }

    render() {
        const { title, text } = this.props.item;
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
