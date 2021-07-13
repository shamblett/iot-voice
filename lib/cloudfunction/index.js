/**
 * Project : iot-voice
 * Author : S. Hamblett <steve.hamblett@linux.com>
 * Date   : 11/07/2021
 * Copyright :  S.Hamblett
 *
 * Triggered from a sensor date message on the iot-voice
 * Cloud Pub/Sub topic.
 *
 * @param {object} message The Pub/Sub message.
 * @param {object} context The event metadata.
 *
 * Writes the incoming sensor data to the destination BigQuery table
 * and logs the incoming data and the result of the update.
 */

// Get a reference to the BigQuery component
const {BigQuery} = require('@google-cloud/bigquery');
const bigquery = new BigQuery();

/**
 * Helper method to get a handle on our BigQuery table.
 */
function getTable () {
 
  const [dataset] = await bigquery.dataset('iotvoice').get();
  const [table] = await dataset.table('status').get();
  return table;
}

// Entry point
exports.subscribe = (message, context) => {
  // The Cloud Pub/Sub Message object.
  const pubSubMessage = message.data
      ? Buffer.from(message.data, 'base64').toString()
      : '-- No JSON Message Body';

  // Log the incoming platform data
  console.log('iot-voice cloud function, incoming data is -->');
  console.log(pubSubMessage);

  // Insert into BigQuery
   var insertRow = [{update: pubSubMessage}];
  getTable().then(([table]) => {
    table.insert(insertRow)
    .then(() => {
      console.log(`Inserted 1 row`)
    });
  });
};
