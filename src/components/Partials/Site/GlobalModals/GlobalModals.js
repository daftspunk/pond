import React, { Component } from 'react';
import PropTypes from 'prop-types';
import { bindActionCreators } from 'redux';
import { connect } from 'react-redux';
import { ALERT, CONFIRM, PROJECT_CREATE, WEBSITE_UPDATE } from '@constants/ModalConstants';
import CreateProject from '@components/Partials/Project/CreateProject/CreateProject';
import UpdateWebsite from '@components/Partials/Website/UpdateWebsite/UpdateWebsite';
import { ModalActions } from '@modules/system/actions/ModalActions';
import AlertModal from './GlobalModals.Alert';
import ConfirmModal from './GlobalModals.Confirm';


class GlobalModals extends Component {
    static propTypes = {
        onCloseModal: PropTypes.func.isRequired,
        modals: PropTypes.array,
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
