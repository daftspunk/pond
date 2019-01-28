import React, { Component } from 'react'
import { Link } from 'react-router-dom'
import { Panel, Button, Level, Icon, Table, VBox, Notification } from '../../../Elements'
import { LogPanel } from '../../../Controls'
import { CREATE_WEBSITE } from '../../../../constants/SlideConstants'
import { ONLINE, OFFLINE, STARTING, STOPPING } from '../../../../constants/EnvironmentConstants'
import styles from '../Index.scss'
import openLocalDir from '../../../../utils/openLocalDir'
import classnames from 'classnames'

export default class SitesDetails extends Component {
    openLocalDirectory(website) {
        openLocalDir(website.fullPath);
    }

    render() {
        const {
            project,
            editWebsite,
            serverLogText,
            serverStatus,
            onSetEditWebsiteModal,
            onStartServer,
            onStopServer
        } = this.props;

        const serveDisabled = editWebsite && !editWebsite.canServe();

        return (
            <VBox>
                <div className={styles.siteTitle}>
                    <div className={classnames(styles.serverStatus, {
                        [styles.serverStatusActive]: serverStatus==ONLINE
                    })}>
                        <Icon icon="circle" />
                    </div>
                    <div className={styles.websiteInfo}>
                        <h4 className="title is-4">{editWebsite.name}</h4>
                        <p className="subtitle is-6">{project.name}</p>
                    </div>
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
                                loading={serverStatus==STARTING}
                                disabled={serveDisabled || serverStatus==ONLINE}>
                                <Icon icon="play" />
                                <span>Start</span>
                            </Button>
                            <Button
                                onClick={()=>onStopServer(editWebsite)}
                                loading={serverStatus==STOPPING}
                                disabled={serveDisabled || serverStatus==OFFLINE}>
                                <Icon icon="stop" />
                                <span>Stop</span>
                            </Button>
                        </Level.Side>
                        <Level.Side align="right">
                            <Button color="info" outlined disabled>
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
                    <Table className={styles.environmentTable}>
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
                {serveDisabled && (
                    <Notification color="danger">
                        The local directory could not be found.
                    </Notification>
                )}
                <VBox.Main>
                    <LogPanel logText={serverLogText} />
                </VBox.Main>
            </VBox>
        );
    }
}
