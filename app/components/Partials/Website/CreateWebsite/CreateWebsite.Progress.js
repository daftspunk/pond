import React, { Component } from 'react'
import { reduxForm } from 'redux-form'
import PropTypes from 'prop-types'
import { Button, ProgressIndicator } from '../../../Elements'
import SlideLayout from '../../../Layouts/Slide/Slide'
import styles from './CreateWebsite.scss';

export default class CreateWebsiteProgress extends Component {
    static propTypes = {
        onCloseSlides: PropTypes.func,
    };

    static defaultProps = {
    };

    render() {
        const { project, onCloseSlides } = this.props;

        const steps = [
            'Downloading',
            'Initializing Environment',
            'Copying Installer',
            'Finished',
        ];

        return (
            <React.Fragment>
                <SlideLayout.Title title={project.name||'Pond'} subtitle="Provisioning" />
                <SlideLayout.Buttons>
                    <div className={styles.progressIndicator}>
                        <h5 className="title is-5">Building your project</h5>
                        <ProgressIndicator steps={steps} currentStepIndex={0} />
                    </div>
                </SlideLayout.Buttons>
                <SlideLayout.Content>
                    Console
                </SlideLayout.Content>
            </React.Fragment>
        )
    }
}
