import React, { Component } from 'react'
import { bindActionCreators } from 'redux'
import { connect } from 'react-redux'
import Index from './Index'
import uuid from 'uuid'
import { PROJECT_CREATE } from '../../../constants/ModalConstants'
import { onOpenModal } from '../../../actions/ModalActions'

const IndexContainer = props => <Index {...props} />

function onCreateWebsite() {
    return () => alert('hi')
}

export default connect(
    state => {
        return {}
    },
    dispatch => {
        return bindActionCreators({
            onCreateWebsite
        }, dispatch)
    }
)(IndexContainer)
