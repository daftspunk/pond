import React, { Component } from 'react';
import * as modalConstants from '../../../../constants/ModalConstants';
import CreateProject from '../../../Partials/Project/CreateProject/CreateProjectContainer';
import AlertModal from './GlobalModals.Alert';
import ConfirmModal from './GlobalModals.Confirm';

export default class GlobalModals extends Component {
    static Alert = AlertModal;
    static Confirm = ConfirmModal;

    modalMap = {
        [modalConstants.ALERT]: AlertModal,
        [modalConstants.CONFIRM]: ConfirmModal,
        [modalConstants.PROJECT_CREATE]: CreateProject,
    };

    render() {
        const modals = this.props.modals.map((item, i) => {
            let Element = this.modalMap[item.type];
            return (
                <Element
                    item={item}
                    key={i}
                    zIndex={i}
                    onClose={(item) => this.props.onCloseModal(item)} />
            );
        });

        return (
            <div className="modals">
                {modals}
            </div>
        );
    }
}
