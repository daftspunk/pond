import React, { Component } from 'react'
import PropTypes from 'prop-types'
import { Button } from '../../Elements'
import styles from './Index.scss'
import image from '../../../images/welcome.png'

export default class NoSites extends Component {
    static propTypes = {
        onSetNewWebsite: PropTypes.func.isRequired,
        project: PropTypes.shape({}),
    };

    static defaultProps = {
        project: {},
    }

    render() {
        const { project, onSetNewWebsite } = this.props;

        return (
            <section className={`hero is-fullheight ${styles.noSitesContainer}`}>
                <div className="hero-body">
                    <div className="container has-text-centered">
                        <img src={image} className={styles.welcomeImage} alt="" />
                        <h4 className="title is-4 is-spaced">Welcome to {project.name||'Pond'}</h4>
                        <p className="subtitle is-6">
                            You don't have any websites in this project yet.
                            Create your first and enjoy October CMS!
                        </p>
                        <p>
                            <Button color="primary" onClick={onSetNewWebsite}>
                                Create your first website
                            </Button>
                        </p>
                    </div>
                </div>
            </section>
        )
    }
}
