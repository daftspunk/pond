import React, { Component } from 'react'
import { Link } from 'react-router-dom'
import { Panel, Button, Level, Icon, Table, VBox } from '../../../Elements'
import { LogPanel } from '../../../Controls'
import { CREATE_WEBSITE } from '../../../../constants/SlideConstants'
import { ONLINE, OFFLINE, STARTING, STOPPING } from '../../../../constants/EnvironmentConstants'
import styles from '../Index.scss'
import openLocalDir from '../../../../utils/openLocalDir'

export default class SitesDetails extends Component {
    openLocalDirectory(website) {
        openLocalDir(website.fullPath);
    }

    render() {
        const {
            project,
            editWebsite,
            editWebsiteLogText,
            editWebsiteLoading,
            onSetEditWebsiteModal,
            onStartServer,
            onStopServer
        } = this.props;

        return (
            <VBox>
                <div className={styles.siteTitle}>
                    <h4 className="title is-4">{editWebsite.name}</h4>
                    <p className="subtitle is-6">{project.name}</p>
                    <Button
                        title="Settings"
                        className={styles.siteSettings}
                        onClick={onSetEditWebsiteModal}
                        rounded>
                        <Icon icon="cog" />
                    </Button>
                </div>
                <div className={styles.siteActions}>
                    <Level>
                        <Level.Side align="left">
                            <Button
                                onClick={()=>onStartServer(editWebsite)}
                                loading={editWebsiteLoading==STARTING}
                                disabled={editWebsiteLoading==ONLINE}>
                                <Icon icon="play" />
                                <span>Start</span>
                            </Button>
                            <Button
                                onClick={()=>onStopServer(editWebsite)}
                                loading={editWebsiteLoading==STOPPING}
                                disabled={editWebsiteLoading==OFFLINE}>
                                <Icon icon="stop" />
                                <span>Stop</span>
                            </Button>
                        </Level.Side>
                        <Level.Side align="right">
                            <Button color="info">
                                <Icon icon="cloud" />
                                <span>Deploy</span>
                            </Button>
                        </Level.Side>
                    </Level>
                </div>
                <div className={`${styles.siteDetails} content`}>
                    <p>
                        {editWebsite.description}
                    </p>
                    <Table>
                        <thead>
                            <tr>
                                <th colSpan="100">Environment</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td style={{width:100}}>Website</td>
                                <td><a href={editWebsite.publicUrl()}>{editWebsite.publicUrl()}</a></td>
                            </tr>
                            <tr>
                                <td>Admin</td>
                                <td><a href={editWebsite.adminUrl()}>{editWebsite.adminUrl()}</a></td>
                            </tr>
                            <tr>
                                <td>Folder</td>
                                <td><a onClick={()=>this.openLocalDirectory(editWebsite)}>Browse local directory</a></td>
                            </tr>
                        </tbody>
                    </Table>
                </div>
                <VBox.Main>
                    <LogPanel logText={editWebsiteLogText} />
                </VBox.Main>
            </VBox>
        );
    }
}
