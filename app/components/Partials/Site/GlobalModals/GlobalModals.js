import React, { Component } from 'react';
import { ALERT, CONFIRM, PROJECT_CREATE } from '../../../../constants/ModalConstants';
import CreateProject from '../../../Partials/Project/CreateProject/CreateProjectContainer';
import AlertModal from './GlobalModals.Alert';
import ConfirmModal from './GlobalModals.Confirm';

export default class GlobalModals extends Component {
    static Alert = AlertModal;
    static Confirm = ConfirmModal;

    modalMap = {
        [ALERT]: AlertModal,
        [CONFIRM]: ConfirmModal,
        [PROJECT_CREATE]: CreateProject,
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
