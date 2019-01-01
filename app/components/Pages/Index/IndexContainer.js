import React, { Component } from 'react';
import { bindActionCreators } from 'redux';
import { connect } from 'react-redux';
import Index from './Index';
import uuid from 'uuid';
import { PROJECT_CREATE } from '../../../constants/ModalConstants';
import { onOpenModal } from '../../../actions/ModalActions';

const IndexContainer = props => <Index {...props} />;

function onCreateWebsite() {
    return () => alert('hi');
}

function mapStateToProps(state) {
    return {};
}

function mapDispatchToProps(dispatch) {
    return bindActionCreators({
        onCreateWebsite
    }, dispatch);
}

export default connect(
    mapStateToProps,
    mapDispatchToProps
)(IndexContainer);
