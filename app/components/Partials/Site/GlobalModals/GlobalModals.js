import React, { Component } from 'react'
import { bindActionCreators } from 'redux'
import { connect } from 'react-redux'
import { ALERT, CONFIRM, PROJECT_CREATE, WEBSITE_UPDATE } from '../../../../constants/ModalConstants'
import { ModalActions } from '../../../../actions/ModalActions'
import AlertModal from './GlobalModals.Alert'
import ConfirmModal from './GlobalModals.Confirm'

import CreateProject from '../../../Partials/Project/CreateProject/CreateProject'
import UpdateWebsite from '../../../Partials/Website/UpdateWebsite/UpdateWebsite'

class GlobalModals extends Component {
    static Alert = AlertModal;
    static Confirm = ConfirmModal;

    modalMap = {
        [ALERT]: AlertModal,
        [CONFIRM]: ConfirmModal,
        [PROJECT_CREATE]: CreateProject,
        [WEBSITE_UPDATE]: UpdateWebsite,
    };

    render() {
        const modals = this.props.modals.map((item, i) => {
            let Element = this.modalMap[item.type];
            return (
                <Element
                    item={item}
                    key={i}
                    zIndex={i}
                    onClose={item=>this.props.onCloseModal(item)} />
            );
        });

        return (
            <div className="modals">
                {modals}
            </div>
        );
    }
}

export default connect(
    state => {
        return {
            modals: state.modals.modals,
        }
    },
    dispatch => {
        return bindActionCreators({
            ...ModalActions
        }, dispatch)
    }
)(GlobalModals)
