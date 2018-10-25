import React, { Component } from 'react'
import { bindActionCreators } from 'redux'
import { connect } from 'react-redux'
import SidebarNav from './SidebarNav'
import uuid from 'uuid'
import { onCreateProjectModal } from '../../../../actions/ProjectActions'

const SidebarNavContainer = props => <SidebarNav {...props} />

export default connect(
    state => {
        return {}
    },
    dispatch => {
        return bindActionCreators({
            onCreateProjectModal
        }, dispatch)
    }
)(SidebarNavContainer)
