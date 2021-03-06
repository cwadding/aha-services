This integration allows you to push features and requirements from Aha! to Microsoft Visual Studio Team Services (VSTS) - previously called Visual Studio Online (VSO).

This integration works with the online version of Visual Studio. If you run Team Foundation Server on-premise then use the separate _Team Foundation Server_ integration instead.

## Features

* One Aha! product is associated with one VSTS project.
* A feature can be sent to VSTS using the _Send to Visual Studio Team Services_ item in the _Action_ menu on the features page.
* Requirements are sent to VSTS together with the feature.
* Only the name, description and attachments of features and requirements are sent.
* If you set up a subscription in VSTS the integration can receive updates about name changes, description changes or status changes.
* The mapping of VSTS states to Aha! workflow statuses is configurable.

## Configuration

You need to be Product Owner in Aha! to set up this integration.

To configure this integration, first configure your Visual Studio Team Services account.

1. Go to _My profile_ and then choose the _Credentials_ tab.
2. Setup the _Alternate Authentication Credentials_. This credential will be used with Aha! (not your normal login credential).

Next create the integration in Aha!

1. Enter the account name of your Visual Studio Team Services account. It is equal to the subdomain of your Visual Studio Team Services account.
2. Enter the alternate credentials you created in Visual Studio Team Services.
3. Click the _Test connection_ button.
4. On success, you should be able to choose a project from Visual Studio Team Services. You also must select an area of this project where features and requirements should be created.
5. Select the workitemtype to which features should be mapped. Then select for each VSTS state to which Aha! workflow status it should be mapped.
6. Repeat step 5 for requirements.
7. Enable the integration and test it by going to one of your features in Aha! and using the _Send to Visual Studio Team Services_ item in the _Action_ menu.
8. The feature should now appear in your Visual Studio Team Services project together with its requirements.

If you want to be able to receive updates from VSTS you must setup a subscription.

1. Copy the Webhook URL from the configuration page.
2. In your Visual Studio Team Services account, go to the project you want to integrate with.
3. Click the small cog in the top right corner to go to the settings.
4. Click on the _Service Hooks_ tab.
5. Add a new service hook by clicking the green plus.
6. Choose the _Web Hooks_ service and click _Next_.
7. Choose the _Work item updated_ trigger from the dropdown menu. You can leave the filters unchanged and click _Next_.
8. In the _Action_ settings, paste the Webhook URL from Aha! into the _URL_ field.
9. Press _Finish_ to create the subscription.

## Troubleshooting

To help you troubleshoot an error, we provide the detailed integration logs below. Contact us at support@aha.io if you need further help.
