import React, { Component } from 'react'
import { bindActionCreators } from 'redux'
import { connect } from 'react-redux'
import GlobalModals from './GlobalModals'
import { onCloseModal } from '../../../../actions/ModalActions'

const GlobalModalsContainer = props => <GlobalModals {...props} />

export default connect(
    state => {
        return {
            modals: state.modals.modals,
        }
    },
    dispatch => {
        return bindActionCreators({
            onCloseModal
        }, dispatch)
    }
)(GlobalModalsContainer)
