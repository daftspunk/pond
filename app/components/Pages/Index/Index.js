import React, { Component } from 'react'
import { bindActionCreators } from 'redux'
import { connect } from 'react-redux'
import Layout from '../../Layouts/Default/Default'
import SidebarNav from '../../Partials/Site/SidebarNav/SidebarNav'
import { Button, Columns } from '../../Elements'
import styles from './Index.scss'
import { SlideActions } from '../../../actions/SlideActions'
import { ProjectActions } from '../../../actions/ProjectActions'
import { WebsiteActions } from '../../../actions/WebsiteActions'
import NoSites from './Index.NoSites'
import SitesList from './Sites/Sites.List'
import SitesDetail from './Sites/Sites.Detail'

class Index extends Component {
    async componentDidMount() {
        await this.props.onFetchProjects();
        await this.props.onSetActiveProject();
        this.props.onFetchWebsites(this.props.project.id);
    }

    render() {
        const { websites } = this.props;

        return (
            <Layout sidebar={<SidebarNav />}>
                {!websites.length ? (
                    <NoSites {...this.props} />
                ) : (
                    <Columns gapless fullheight>
                        <Columns.Column size={4} className={styles.sitesList}>
                            <SitesList {...this.props} />
                        </Columns.Column>
                        <Columns.Column size={8}>
                            <SitesDetail {...this.props} />
                        </Columns.Column>
                    </Columns>
                )}
            </Layout>
        );
    }
}

export default connect(
    state => {
        // If no edit website is found, use the first available
        const websites = state.website.websites || [];
        const editWebsite = state.website.editWebsite || websites && websites[0] || {};

        return {
            websites,
            editWebsite,
            project: state.project.project || {}
        }
    },
    dispatch => {
        return bindActionCreators({
            ...WebsiteActions,
            ...ProjectActions
        }, dispatch)
    }
)(Index)
