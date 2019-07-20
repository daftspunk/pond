import React, { Component } from 'react';
import { bindActionCreators } from 'redux';
import { connect } from 'react-redux';
import * as slides from '@constants/SlideConstants';
import Button from '../../../Elements/Button/Button';
import CreateWebsite from '../../Website/CreateWebsite/CreateWebsite';

class GlobalSlides extends Component {
    render() {
        const { activeSlide } = this.props;
        return (
            <React.Fragment>
                {activeSlide == slides.CREATE_WEBSITE && <CreateWebsite />}
            </React.Fragment>
        );
    }
}

export default connect(
    state => ({
        activeSlide: state.slide.activeSlide,
    }),
    dispatch => bindActionCreators({
    }, dispatch)
)(GlobalSlides)
