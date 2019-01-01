import React, { Component } from 'react';
import { bindActionCreators } from 'redux';
import { connect } from 'react-redux';
import GlobalModals from './GlobalModals';
import { onCloseModal } from '../../../../actions/ModalActions';

const GlobalModalsContainer = props => <GlobalModals {...props} />;

function mapStateToProps(state) {
    return {
        modals: state.modals.modals,
    };
}

function mapDispatchToProps(dispatch) {
    return bindActionCreators({
        onCloseModal
    }, dispatch)
}

export default connect(
    mapStateToProps,
    mapDispatchToProps
)(GlobalModalsContainer);
