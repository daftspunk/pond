// import { remote } from 'electron';

const remote = window.require('electron').remote;
const fs = remote.require('fs-extra');

export default fs;
