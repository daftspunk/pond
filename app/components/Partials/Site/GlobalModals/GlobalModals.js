import React, { Component } from 'react'
import PropTypes from 'prop-types'
import { bindActionCreators } from 'redux'
import { connect } from 'react-redux'
import { ALERT, CONFIRM, PROJECT_CREATE, WEBSITE_UPDATE } from '../../../../constants/ModalConstants'
import { ModalActions } from '../../../../actions/ModalActions'
import AlertModal from './GlobalModals.Alert'
import ConfirmModal from './GlobalModals.Confirm'

import CreateProject from '../../../Partials/Project/CreateProject/CreateProject'
import UpdateWebsite from '../../../Partials/Website/UpdateWebsite/UpdateWebsite'

class GlobalModals extends Component {
    static propTypes = {
        onCloseModal: PropTypes.func.isRequired,
        modals: PropTypes.shape([]),
    };

    static defaultProps = {
        modals: [],
    };

    static Alert = AlertModal;

    static Confirm = ConfirmModal;

    modalMap = {
        [ALERT]: AlertModal,
        [CONFIRM]: ConfirmModal,
        [PROJECT_CREATE]: CreateProject,
        [WEBSITE_UPDATE]: UpdateWebsite,
    };

    render() {
        const { modals, onCloseModal } = this.props;

        const foundModals = modals.map((item, i) => {
            const Element = this.modalMap[item.type];
            return (
                <Element
                    item={item}
                    key={i}
                    zIndex={i}
                    onClose={modalItem => onCloseModal(modalItem)} />
            );
        });

        return (
            <div className="modals">
                {foundModals}
            </div>
        );
    }
}

export default connect(
    state => ({
        modals: state.modals.modals,
    }),
    dispatch => bindActionCreators({
        ...ModalActions
    }, dispatch)
)(GlobalModals)
