import React, { Component } from 'react'
import PropTypes from 'prop-types';
import { bindActionCreators } from 'redux'
import { connect } from 'react-redux'
import Layout from '../../Layouts/Default/Default'
import SidebarNav from '../../Partials/Site/SidebarNav/SidebarNav'
import { Columns } from '../../Elements'
import { OFFLINE } from '../../../constants/EnvironmentConstants'
import styles from './Index.scss'
import { ProjectActions } from '../../../actions/ProjectActions'
import { ServerActions } from '../../../actions/ServerActions'
import { WebsiteActions } from '../../../actions/WebsiteActions'
import NoSites from './Index.NoSites'
import SitesList from './Sites/Sites.List'
import SitesDetail from './Sites/Sites.Detail'

class Index extends Component {
    static propTypes = {
        onFetchProjects: PropTypes.func.isRequired,
        onSetActiveProject: PropTypes.func.isRequired,
        onFetchWebsites: PropTypes.func.isRequired,
        project: PropTypes.shape({}),
        websites: PropTypes.arrayOf(PropTypes.shape({})),
    };

    static defaultProps = {
        project: {},
        websites: [],
    }

    async componentDidMount() {
        const { onFetchProjects, onSetActiveProject, onFetchWebsites, project } = this.props;

        await onFetchProjects();
        await onSetActiveProject();
        onFetchWebsites(project.id);
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
        const id = state.website.editWebsite && state.website.editWebsite.id || 0;
        return {
            websites: state.website.websites,
            editWebsite: state.website.editWebsite || {},
            serverStatus: state.server.status[id] || OFFLINE,
            serverLogText: state.server.logText[id],
            project: state.project.project || {}
        }
    },
    dispatch => bindActionCreators({
        ...ServerActions,
        ...WebsiteActions,
        ...ProjectActions
    }, dispatch)
)(Index)
