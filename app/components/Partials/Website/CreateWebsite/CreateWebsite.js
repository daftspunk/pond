import React, { Component } from 'react'
import { bindActionCreators } from 'redux'
import { connect } from 'react-redux'
import PropTypes from 'prop-types'
import { Button } from '../../../Elements'
import { WebsiteActions } from '../../../../actions/WebsiteActions'
import { SlideActions } from '../../../../actions/SlideActions'
import SlideLayout from '../../../Layouts/Slide/Slide'
import WebsiteForm from './CreateWebsite.Form'
import WebsiteProgress from './CreateWebsite.Progress'

class CreateWebsite extends Component {
    static propTypes = {
        onCloseSlides: PropTypes.func.isRequired,
        newWebsiteLoading: PropTypes.bool.isRequired,
        initialWebsiteValues: PropTypes.shape({}),
    };

    static defaultProps = {
        initialWebsiteValues: {},
    };

    render() {
        const { onCloseSlides, newWebsiteLoading, initialWebsiteValues } = this.props;

        return (
            <SlideLayout close={<Button remove size="medium" onClick={onCloseSlides} />}>
                {newWebsiteLoading ? (
                    <WebsiteProgress {...this.props} />
                ) : (
                    <WebsiteForm {...this.props} initialValues={initialWebsiteValues} />
                )}
            </SlideLayout>
        )
    }
}

export default connect(
    state => {
        const initialWebsiteValues = {
            localPort: 8080
        }

        return {
            project: state.project.project || {},
            newWebsiteStep: state.website.newWebsiteStep,
            newWebsiteLogText: state.website.newWebsiteLogText,
            newWebsiteLoading: state.website.newWebsiteLoading,
            initialWebsiteValues
        }
    },
    dispatch => bindActionCreators({
        ...SlideActions,
        ...WebsiteActions
    }, dispatch)
)(CreateWebsite)
