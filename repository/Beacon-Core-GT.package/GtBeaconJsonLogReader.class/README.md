GtRrRunnerLogReader reads a log file typically created by a headless remote runner and loads signals that respond to `#initializeFromTimestamp:andData:`.

```
GtRrRunnerLogReader new
	filename: 'remoteRunner.log';
	load
```