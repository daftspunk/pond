import React, { Component } from 'react';
import Layout from '../../Layouts/Default/Default';
import SidebarNav from '../../Partials/Site/SidebarNav/SidebarNav';
import { Button } from '../../Elements';
import styles from './Index.scss';
import image from '../../../images/welcome.png';

export default class Index extends Component {
    render() {
        return (
            <Layout sidebar={<SidebarNav />}>
                <section className={`hero is-fullheight ${styles.noSitesContainer}`}>
                    <div className="hero-body">
                        <div className="container has-text-centered">
                            <img src={image} className={styles.welcomeImage} />
                            <h4 className="title is-4 is-spaced">Welcome to The Pond</h4>
                            <p className="subtitle is-6">
                                You don't have any websites in this project yet.
                                Create your first and enjoy October CMS!
                            </p>
                            <p>
                                <Button color="info" onClick={this.props.onCreateWebsite}>
                                    Create your first website
                                </Button>
                            </p>
                        </div>
                    </div>
                </section>
            </Layout>
        );
    }
}
