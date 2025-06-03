# Pasteboard Privacy Headless Test

This project demonstrates an issue with the new macOS pasteboard privacy changes.
In headless apps (`LSUIElement` + `NSApplication.setActivationPolicy(.prohibited)`) a hang occurs when trying to access the pasteboard and the permission prompt never appears.
When the permission prompt should appear, an error message is printed instead:

```
ERROR: Setting <_NSAlertButton: 0x13a910660> as the first responder for window <_NSAlertPanel: 0x13a804e00> windowNumber=a079, but it is in a different window ((null))! This would eventually crash when the view is freed. The first responder will be set to nil.
(
    0   AppKit                              0x0000000189a2239c -[NSWindow _validateFirstResponder:] + 348
    1   AppKit                              0x0000000189a221f4 -[NSWindow _setFirstResponder:] + 28
    2   AppKit                              0x0000000189afbca4 -[NSWindow _realMakeFirstResponder:] + 516
    3   AppKit                              0x0000000189b0a928 -[NSWindow _selectFirstKeyView] + 544
    4   AppKit                              0x0000000189f97874 -[_NSAlertPanel _selectFirstKeyView] + 60
    5   AppKit                              0x0000000189b09f68 -[NSWindow _setUpFirstResponder] + 144
    6   AppKit                              0x0000000189c3b1d4 -[NSApplication _orderFrontModalWindow:relativeToWindow:] + 540
    7   AppKit                              0x0000000189c3adb0 -[NSApplication _commonBeginModalSessionForWindow:relativeToWindow:modalDelegate:didEndSelector:contextInfo:] + 1400
    8   AppKit                              0x0000000189c3a7b0 __35-[NSApplication runModalForWindow:]_block_invoke_2 + 36
    9   AppKit                              0x0000000189c3a770 __35-[NSApplication runModalForWindow:]_block_invoke + 108
    10  AppKit                              0x0000000189c3a03c _NSTryRunModal + 100
    11  AppKit                              0x0000000189c39ef4 -[NSApplication runModalForWindow:] + 292
    12  AppKit                              0x0000000189f98278 __19-[NSAlert runModal]_block_invoke_2 + 120
    13  AppKit                              0x0000000189f981e4 __19-[NSAlert runModal]_block_invoke + 108
    14  AppKit                              0x0000000189c3a03c _NSTryRunModal + 100
    15  AppKit                              0x0000000189ca89e0 -[NSAlert runModal] + 140
    16  AppKit                              0x0000000189ebd804 __swift_deallocate_boxed_opaque_existential_1 + 9404
    17  AppKit                              0x0000000189ebd234 __swift_deallocate_boxed_opaque_existential_1 + 7916
    18  AppKit                              0x0000000189d93a20 block_destroy_helper + 10952
    19  AppKit                              0x0000000189d93678 block_destroy_helper + 10016
    20  AppKit                              0x000000018a2e3358 ___NSPasteboardInstallPrevalidationCallbacks_block_invoke.495 + 272
    21  CoreFoundation                      0x0000000185bb5254 ___onqueue_CFPasteboardShowApprovalDialogIfNecessaryForPasteboard_block_invoke_2 + 128
    22  CoreFoundation                      0x0000000185bb5118 ___onqueue_CFPasteboardShowApprovalDialogIfNecessaryForPasteboard_block_invoke + 148
    23  CoreFoundation                      0x0000000185bb507c __CFPASTEBOARD_IS_SHOWING_AN_APPROVAL_DIALOG__ + 24
    24  CoreFoundation                      0x0000000185bb4c40 _onqueue_CFPasteboardShowApprovalDialogIfNecessaryForPasteboard + 232
    25  CoreFoundation                      0x0000000185bb1424 -[_CFPasteboardEntry requestDataForPasteboard:generation:immediatelyAvailableResult:] + 816
    26  CoreFoundation                      0x0000000185ae573c __CFPasteboardCopyData_block_invoke + 152
    27  CoreFoundation                      0x0000000185bb23bc ____CFPasteboardPerformOnQueue_block_invoke + 292
    28  libdispatch.dylib                   0x0000000100658f20 _dispatch_block_sync_invoke + 228
    29  libdispatch.dylib                   0x00000001006712dc _dispatch_client_callout + 16
    30  libdispatch.dylib                   0x0000000100666dd4 _dispatch_lane_barrier_sync_invoke_and_complete + 192
    31  libdispatch.dylib                   0x000000010065ae40 _dispatch_sync_block_with_privdata + 440
    32  CoreFoundation                      0x0000000185ae4f34 CFPasteboardCopyData + 652
    33  AppKit                              0x000000018a2e0088 -[NSPasteboard _dataWithoutConversionForTypeIdentifier:securityScoped:] + 372
    34  AppKit                              0x000000018a2e03a0 -[NSPasteboard _dataForType:index:usesPboardTypes:combinesItems:securityScoped:] + 444
    35  AppKit                              0x000000018a2e27f0 -[NSPasteboard stringForType:] + 28
    36  PasteboardPrivacyHeadlessTest.debug 0x0000000100425cf4 $s29PasteboardPrivacyHeadlessTest11AppDelegateC29applicationDidFinishLaunchingyy10Foundation12NotificationVF + 1360
    37  PasteboardPrivacyHeadlessTest.debug 0x000000010042695c $s29PasteboardPrivacyHeadlessTest11AppDelegateC29applicationDidFinishLaunchingyy10Foundation12NotificationVFTo + 156
    38  CoreFoundation                      0x0000000185ade62c __CFNOTIFICATIONCENTER_IS_CALLING_OUT_TO_AN_OBSERVER__ + 148
    39  CoreFoundation                      0x0000000185b6dce8 ___CFXRegistrationPost_block_invoke + 92
    40  CoreFoundation                      0x0000000185b6dc2c _CFXRegistrationPost + 436
    41  CoreFoundation                      0x0000000185aada78 _CFXNotificationPost + 740
    42  Foundation                          0x0000000187066680 -[NSNotificationCenter postNotificationName:object:userInfo:] + 88
    43  AppKit                              0x0000000189a1823c -[NSApplication _postDidFinishNotification] + 284
    44  AppKit                              0x0000000189a17fec -[NSApplication _sendFinishLaunchingNotification] + 172
    45  AppKit                              0x0000000189a165e8 -[NSApplication(NSAppleEventHandling) _handleAEOpenEvent:] + 488
    46  AppKit                              0x0000000189a161fc -[NSApplication(NSAppleEventHandling) _handleCoreEvent:withReplyEvent:] + 488
    47  Foundation                          0x000000018708ee40 -[NSAppleEventManager dispatchRawAppleEvent:withRawReply:handlerRefCon:] + 316
    48  Foundation                          0x000000018708ec38 _NSAppleEventManagerGenericHandler + 80
    49  AE                                  0x000000018d4e413c _AppleEventsCheckInAppWithBlock + 13864
    50  AE                                  0x000000018d4e3a7c _AppleEventsCheckInAppWithBlock + 12136
    51  AE                                  0x000000018d4dd044 aeProcessAppleEvent + 484
    52  HIToolbox                           0x00000001914cf828 AEProcessAppleEvent + 68
    53  AppKit                              0x0000000189a0fdb8 _DPSNextEvent + 1456
    54  AppKit                              0x000000018a3ae5b0 -[NSApplication(NSEventRouting) _nextEventMatchingEventMask:untilDate:inMode:dequeue:] + 688
    55  AppKit                              0x0000000189a02c64 -[NSApplication run] + 480
    56  PasteboardPrivacyHeadlessTest.debug 0x0000000100425454 $s29PasteboardPrivacyHeadlessTestyyXEfU_ + 172
    57  PasteboardPrivacyHeadlessTest.debug 0x000000010042553c $s10ObjectiveC15autoreleasepool8invokingq_q_yxYKXE_txYKs5ErrorRzRi__r0_lF + 144
    58  PasteboardPrivacyHeadlessTest.debug 0x0000000100425388 __debug_main_executable_dylib_entry_point + 72
    59  dyld                                0x000000018565eb98 start + 6076
)
```  
