import React, { Component } from 'react'
import { Link } from 'react-router-dom'
import { Panel, Button, Level, Icon, Table } from '../../../Elements'
import { CREATE_WEBSITE } from '../../../../constants/SlideConstants'
import styles from '../Index.scss'

export default class SitesDetails extends Component {
    render() {
        const { editWebsite } = this.props;

        return (
            <div>
                <div className={styles.siteTitle}>
                    <h4 className="title is-4">Landing pages minisite</h4>
                    <p className="subtitle is-6">The Pond Project</p>
                    <Button title="Settings" className={styles.siteSettings} rounded>
                        <Icon icon="cog" />
                    </Button>
                </div>
                <div className={styles.siteActions}>
                    <Level>
                        <Level.Side align="left">
                            <Button>
                                <Icon icon="play" />
                                <span>Start</span>
                            </Button>
                            <Button>
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
                <div className={styles.siteDetails}>
                    <p>
                        Static landing pages for various ACME marketing campaigns, hosted on a separte server. Project in basecamp
                    </p>
                    <hr />
                    <h6 className="title is-6">Environment</h6>
                    <Table>
                        <tbody>
                            <tr>
                                <td style={{width:100}}>Website</td>
                                <td><a href="#">localhost:9291</a></td>
                            </tr>
                            <tr>
                                <td>Admin</td>
                                <td><a href="#">localhost:9291/backend</a></td>
                            </tr>
                            <tr>
                                <td>Folder</td>
                                <td><a href="#">Browse local directory</a></td>
                            </tr>
                        </tbody>
                    </Table>
                </div>
            </div>
        );
    }
}
