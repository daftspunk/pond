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
    componentDidMount() {
        this.props.onFetchProjects();
        this.props.onSetActiveProject();
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
        return {
            project: state.project.project || {},
            websites: state.website.websites,
            editWebsite: state.website.editWebsite
        }
    },
    dispatch => {
        return bindActionCreators({
            ...WebsiteActions,
            ...ProjectActions
        }, dispatch)
    }
)(Index)
