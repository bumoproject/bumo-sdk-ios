---
id: sdk_ios
title: BUMO IOS SDK
sidebar_label: IOS
---

## 概述
本文档详细说明Bumo IOS SDK常用接口文档, 使开发者更方便地操作和查询BU区块链。

## 包引入

环境依赖ios 8.0或更高系统版本。

1. 下载[Bumo ios sdk](https://github.com/bumoproject/bumo-sdk-ios/releases)包。
2. 解压缩bumo-ios-sdk-{版本号}.zip包。
2. 将libs目录下的sdk_ios.framework拖到项目中，并选择"Copy items if needed"。
3. 在"Build Phases"的"Link Binary With Libraries"中添加"libc++.tbd"。
4. 在"Build Setting"的"Other Linker Flags"添加"-ObjC"。
5. 在项目中添加头文件，命令是"#import <sdk_ios/sdk_ios.h>"。

## 请求参数与响应数据格式

### 请求参数

接口的请求参数的类名，是**服务名** + **方法名** + **Request**，比如: 账户服务下的[getInfo](#getinfo)接口的请求参数格式是AccountGetInfoRequest。

请求参数的成员，是各个接口的入参的成员。例如：账户服务下的[getInfo](#getinfo)接口的入参成员是address，那么该接口的请求参数的完整结构如下：
```objc
@interface AccountGetInfoRequest : NSObject {
@private
	NSString *_address;
}
-(void)setAddress:(NSString *)address;
-(NSString *)getAddress;
```

### 响应数据

接口的响应数据的类名，是**服务名** + **方法名** + **Response**，比如：账户服务下的[getNonce](#getnonce)接口的响应数据格式是AccountGetNonceResponse。

响应数据的成员，包括错误码、错误描述和返回结果，比如账户服务下的[getNonce](#getnonce)接口的响应数据的成员如下：

```objc
@interface AccountGetNonceResponse : NSObject
@property (nonatomic, assign) int32_t errorCode;
@property (nonatomic, copy) NSString *errorDesc;
@property (nonatomic, strong) AccountGetNonceResult *result;
@end
```

说明：
1. errorCode: 错误码。0表示无错误，大于0表示有错误
2. errorDesc: 错误描述。
3. result: 返回结果。一个结构体，其类名是[服务名][方法名]Result，其成员是各个接口返回值的成员，例如：账户服务下的getNonce接口的结果类名是AccountGetNonceResult，成员有nonce, 完整结构如下：
```objc
@interface AccountGetNonceResult : NSObject
@property (nonatomic, assign) int64_t nonce;
@end
```

## 使用方法

这里介绍SDK的使用流程，首先需要生成SDK实例，然后调用相应服务的接口，其中服务包括[账户服务](#账户服务)、[资产服务](#资产服务)、[合约服务](#合约服务)、[交易服务](#交易服务)、[区块服务](#区块服务)，接口按使用分类分为[生成公私钥地址](#生成公私钥地址)、[有效性校验](#有效性校验)、[查询](#查询)、[广播交易](#广播交易)相关接口。

### 生成SDK实例

调用SDK的接口getInstance来实现

#### 简单配置

调用如下：

```objc
NSString *url = @"http://seed1.bumotest.io:26002";
SDK *sdk = [[SDK sharedInstance] setUrl: url];
```
#### 超时配置

调用如下：
```objc
NSString *url = @"http://seed1.bumotest.io:26002";
SDKConfigure *sdkConfigure = [SDKConfigure new];
[sdkConfigure setTimeOut: 60];

SDK *sdk = [[[SDK sharedInstance] setUrl: url] setConfigure: sdkConfigure];
```
### 生成公私钥地址

此接口生成BU区块链账户的公钥、私钥和地址，直接调用账户服务下的create接口即可，调用如下：

```objc 
AccountService *accountService = [[[SDK sharedInstance] setUrl:@"http://seed1.bumotest.io:26002"] getAccountService];
AccountCreateResponse *response = [accountService create];
if (response.errorCode == 0) {
    NSLog(@"%@", [response.result yy_modelToJSONString]);
} else {
    NSLog(@"%@", response.errorDesc);
}
```

### 有效性校验

此接口用于校验信息的有效性的，直接调用相应的接口即可，比如，校验账户地址有效性，调用如下：
```objc
// 初始化请求参数
AccountService *accountService = [sdk getAccountService];
AccountCheckValidRequest *request = [AccountCheckValidRequest new];
[request setAddress:@""];

// 调用checkValid接口
AccountCheckValidResponse *response = [accountService checkValid: nil];
if (response.errorCode == 0) {
    NSLog(@"%@", [response.result yy_modelToJSONString]);
} else {
    NSLog(@"%@", response.errorDesc);
}
```

### 查询
此接口用于查询BU区块链上的数据，直接调用相应的接口即可，比如，查询账户信息，调用如下：
```objc
// 初始化请求参数
NSString *address = @"buQnnUEBREw2hB6pWHGPzwanX7d28xk6KVcp";
AccountService *accountService = [[[SDK sharedInstance] setUrl:@"http://seed1.bumotest.io:26002"] getAccountService];
AccountGetInfoRequest *request = [AccountGetInfoRequest new];
[request setAddress : address];

// 调用getInfo接口
AccountGetInfoResponse *response = [accountService getInfo : request];
if (response.errorCode == 0) {
    NSLog(@"%@", [response.result yy_modelToJSONString]);
} else {
    NSLog(@"%@", response.errorDesc);
}
```

### 广播交易
广播交易是指通过广播的方式发起交易。广播交易包括以下步骤：

1. [获取账户nonce值](#获取账户nonce值)
2. [构建操作](#构建操作)
3. [序列化交易](#序列化交易)
4. [签名交易](#签名交易)
5. [提交交易](#提交交易)

#### 获取账户nonce值

开发者可自己维护各个账户nonce，在提交完一个交易后，自动递增1，这样可以在短时间内发送多笔交易，否则，必须等上一个交易执行完成后，账户的nonce值才会加1。接口详情请见[getNonce](#getnonce)，调用如下：
```objc
// 初始化请求参数
NSString *address = @"buQnnUEBREw2hB6pWHGPzwanX7d28xk6KVcp";
AccountService *accountService = [[[SDK sharedInstance] setUrl:@"http://seed1.bumotest.io:26002"] getAccountService];
AccountGetNonceRequest * request = [AccountGetNonceRequest new];
[request setAddress : address];

// 调用getNonce接口
AccountGetNonceResponse *response = [accountService getNonce : request];
if (response.errorCode == 0) {
    NSLog(@"%@", [response.result yy_modelToJSONString]);
} else {
    NSLog(@"%@", response.errorDesc);
}
```

#### 构建操作

这里的操作是指在交易中做的一些动作，便于序列化交易和评估费用。操作详情请见[操作](#操作)。例如：构建发送BU操作BUSendOperation，接口调用如下：
```objc
// 初始化变量
NSString *sourceAddress = @"buQnnUEBREw2hB6pWHGPzwanX7d28xk6KVcp";
NSString *destAddress = @"buQhapCK83xPPdjQeDuBLJtFNvXYZEKb6tKB";
int64_t amount = 1000000;

// 构建BUSendOperation
BUSendOperation *operation = [BUSendOperation new];
[operation setSourceAddress: sourceAddress];
[operation setDestAddress: destAddress];
[operation setAmount: amount];
```

#### 序列化交易

该接口用于序列化交易，并生成交易Blob串，便于网络传输。其中nonce和operation是上面接口得到的，接口详情请见[buildBlob](#buildblob)，调用如下：
```objc
// 初始化变量
int64_t gasPrice = 1000;
int64_t feeLimit = 1000000;

// 初始化请求参数
TransactionBuildBlobRequest *buildBlobRequest = [TransactionBuildBlobRequest new];
[buildBlobRequest setSourceAddress : sourceAddress];
[buildBlobRequest setNonce : nonce];
[buildBlobRequest setGasPrice : gasPrice];
[buildBlobRequest setFeeLimit : feeLimit];
[buildBlobRequest addOperation : operation];

// 调用buildBlob接口
TransactionService *transactionServer = [sdk getTransactionService];
TransactionBuildBlobResponse *buildBlobResponse = [transactionServer buildBlob : buildBlobRequest];
if (buildBlobResponse.errorCode == 0) {
    NSLog(@"blob: %@, hash: %@", buildBlobResponse.result.transactionBlob, buildBlobResponse.result.transactionHash);
} else {
    NSLog(@"error: %@", buildBlobResponse.errorDesc);
    return;
}
```

#### 签名交易

该接口用于交易发起者使用其账户私钥对交易进行签名。其中transactionBlob是上面接口得到的，接口详情请见[sign](#sign)，调用如下：
```objc
// 初始化请求参数
NSString *privateKey = @"privbyQCRp7DLqKtRFCqKQJr81TurTqG6UKXMMtGAmPG3abcM9XHjWvq";
TransactionSignRequest *signRequest = [TransactionSignRequest new];
[signRequest setBlob : buildBlobResponse.result.transactionBlob];
[signRequest addPrivateKey : privateKey];

// 调用sign接口
TransactionSignResponse * signResponse = [transactionServer sign : signRequest];
if (signResponse.errorCode == 0) {
    NSLog(@"sign response: %@", [signResponse yy_modelToJSONString]);
} else {
    NSLog(@"error: %@", signResponse.errorDesc);
    return;
}
```

#### 提交交易

该接口用于向BU区块链发送交易请求，触发交易的执行。其中transactionBlob和signResult是上面接口得到的，接口详情请见[submit](#submit)，调用如下：
```objc
// 初始化请求参数
TransactionSubmitRequest *submitRequest = [TransactionSubmitRequest new];
[submitRequest setTransactionBlob : buildBlobResponse.result.transactionBlob];
[submitRequest setSignatures : [signResponse.result.signatures copy]];

// 调用submit接口
TransactionSubmitResponse *submitResponse = [transactionServer submit : submitRequest];
if (submitResponse.errorCode == 0) {
    NSLog(@"submit response: %@", [submitResponse yy_modelToJSONString]);
} else {
    NSLog(@"error: %@", submitResponse.errorDesc);
}
```


## 交易服务

交易服务主要是交易相关的接口，目前有5个接口：`buildBlob`, `evaluateFee`, `sign`, `submit`, `getInfo`。

### buildBlob

> **注意:** 调用**buildBlob**之前需要构建一些操作，详情见[操作](#操作)。

- **接口说明**

   该接口用于序列化交易，生成交易Blob串，便于网络传输。

- **调用方法**

  `TransactionBuildBlobResponse *) buildBlob : (TransactionBuildBlobRequest *) transactionBuildBlobRequest;`

- **请求参数**

   参数      |     类型     |        描述       
   ----------- | ------------ | ---------------- 
   sourceAddress|NSString*|必填，发起该操作的源账户地址
   nonce|int64_t|必填，待发起的交易序列号，函数里+1，大小限制[1, max(int64)]
   gasPrice|int64_t|必填，交易燃料单价，单位MO，1 BU = 10^8 MO，大小限制[1000, max(int64)]
   feeLimit|int64_t|必填，交易要求的最低的手续费，单位MO，1 BU = 10^8 MO，大小限制[1, max(int64)]
   operation|NSArray<BaseOperation *> *|必填，待提交的操作列表，不能为空
   ceilLedgerSeq|int64_t|选填，距离当前区块高度指定差值的区块内执行的限制，当区块超出当时区块高度与所设差值的和后，交易执行失败。必须大于等于0，是0时不限制
   metadata|NSString*|选填，备注

- **响应数据**

   参数      |     类型     |        描述       
   ----------- | ------------ | ---------------- 
   transactionBlob|NSString*|Transaction序列化后的16进制字符串
   hash|NSString*|交易hash

- **错误码**

   异常       |     错误码   |   描述   
   -----------  | ----------- | -------- 
   INVALID_SOURCEADDRESS_ERROR|11002|Invalid sourceAddress
   INVALID_NONCE_ERROR|11048|Nonce must be between 1 and max(int64)
   INVALID_DESTADDRESS_ERROR|11003|Invalid destAddress
   INVALID_INITBALANCE_ERROR|11004|InitBalance must be between 1 and max(int64) 
   SOURCEADDRESS_EQUAL_DESTADDRESS_ERROR|11005|SourceAddress cannot be equal to destAddress
   INVALID_ISSUE_AMOUNT_ERROR|11008|AssetAmount this will be issued must be between 1 and max(int64)
   INVALID_DATAKEY_ERROR|11011|The length of key must be between 1 and 1024
   INVALID_DATAVALUE_ERROR|11012|The length of value must be between 0 and 256000
   INVALID_DATAVERSION_ERROR|11013|The version must be equal to or greater than 0 
   INVALID_MASTERWEIGHT _ERROR|11015|MasterWeight must be between 0 and max(uint32)
   INVALID_SIGNER_ADDRESS_ERROR|11016|Invalid signer address
   INVALID_SIGNER_WEIGHT _ERROR|11017|Signer weight must be between 0 and max(uint32)
   INVALID_TX_THRESHOLD_ERROR|11018|TxThreshold must be between 0 and max(int64)
   INVALID_OPERATION_TYPE_ERROR|11019|Operation type must be between 1 and 100
   INVALID_TYPE_THRESHOLD_ERROR|11020|TypeThreshold must be between 0 and max(int64)
   INVALID_ASSET_CODE _ERROR|11023|The length of asset code must be between 1 and 64
   INVALID_ASSET_AMOUNT_ERROR|11024|AssetAmount must be between 0 and max(int64)
   INVALID_BU_AMOUNT_ERROR|11026|BuAmount must be between 0 and max(int64)
   INVALID_ISSUER_ADDRESS_ERROR|11027|Invalid issuer address
   NO_SUCH_TOKEN_ERROR|11030|No such token
   INVALID_TOKEN_NAME_ERROR|11031|The length of token name must be between 1 and 1024
   INVALID_TOKEN_SYMBOL_ERROR|11032|The length of symbol must be between 1 and 1024
   INVALID_TOKEN_DECIMALS_ERROR|11033|Decimals must be between 0 and 8
   INVALID_TOKEN_TOTALSUPPLY_ERROR|11034|TotalSupply must be between 1 and max(int64)
   INVALID_TOKENOWNER_ERRPR|11035|Invalid token owner
   INVALID_CONTRACTADDRESS_ERROR|11037|Invalid contract address
   CONTRACTADDRESS_NOT_CONTRACTACCOUNT_ERROR|11038|ContractAddress is not a contract account
   INVALID_TOKEN_AMOUNT_ERROR|11039|Token amount must be between 1 and max(int64)
   SOURCEADDRESS_EQUAL_CONTRACTADDRESS_ERROR|11040|SourceAddress cannot be equal to contractAddress
   INVALID_FROMADDRESS_ERROR|11041|Invalid fromAddress
   FROMADDRESS_EQUAL_DESTADDRESS_ERROR|11042|FromAddress cannot be equal to destAddress
   INVALID_SPENDER_ERROR|11043|Invalid spender
   PAYLOAD_EMPTY_ERROR|11044|Payload cannot be empty
   INVALID_LOG_TOPIC_ERROR|11045|The length of a log topic must be between 1 and 128
   INVALID_LOG_DATA_ERROR|11046|The length of one piece of log data must be between 1 and 1024
   INVALID_CONTRACT_TYPE_ERROR|11047|Type must be equal or bigger than 0 
   INVALID_NONCE_ERROR|11048|Nonce must be between 1 and max(int64)
   INVALID_ GASPRICE_ERROR|11049|GasPrice must be between 1000 and max(int64)
   INVALID_FEELIMIT_ERROR|11050|FeeLimit must be between 1 and max(int64)
   OPERATIONS_EMPTY_ERROR|11051|Operations cannot be empty
   INVALID_CEILLEDGERSEQ_ERROR|11052|CeilLedgerSeq must be equal to or greater than 0
   OPERATIONS_ONE_ERROR|11053|One of the operations cannot be resolved
   REQUEST_NULL_ERROR|12001|Request parameter cannot be null
   SYSTEM_ERROR|20000|System error

- **示例**

    ```objc
    // 初始化变量
    NSString* senderAddresss = @"buQfnVYgXuMo3rvCEpKA6SfRrDpaz8D8A9Ea";
    NSString* destAddress = @"buQsurH1M4rjLkfjzkxR9KXJ6jSu2r9xBNEw";
    int64_t buAmount = [Tools BU2MO : 10.9];
    int64_t gasPrice = 1000;
    int64_t feeLimit = [Tools BU2MO : 0.01];
    int64_t nonce = 1;

    // 构建sendBU操作
    BUSendOperation *operation = [BUSendOperation new];
    [operation setSourceAddress: senderAddresss];
    [operation setDestAddress: destAddress];
    [operation setAmount: buAmount];

    // 初始化请求参数
    TransactionBuildBlobRequest *buildBlobRequest = [TransactionBuildBlobRequest new];
    [buildBlobRequest setSourceAddress : senderAddresss];
    [buildBlobRequest setNonce : nonce];
    [buildBlobRequest setGasPrice : gasPrice];
    [buildBlobRequest setFeeLimit : feeLimit];
    [buildBlobRequest addOperation : operation];

    // 调用buildBlob接口
    TransactionService *transactionServer = [[[SDK sharedInstance] setUrl:@"http://seed1.bumotest.io:26002"] getTransactionService];
    TransactionBuildBlobResponse *buildBlobResponse = [transactionServer buildBlob : buildBlobRequest];
    if (buildBlobResponse.errorCode == 0) {
        NSLog(@"blob: %@, hash: %@", buildBlobResponse.result.transactionBlob, buildBlobResponse.result.transactionHash);
    } else {
        NSLog(@"error: %@", buildBlobResponse.errorDesc);
        return;
    }
    ```

### evaluateFee

- **接口说明**

   该接口实现交易的费用评估。

- **调用方法**

  `TransactionEvaluateFeeResponse *) evaluateFee : (TransactionEvaluateFeeRequest *) transactionEvaluateFeeRequest;`

- **请求参数**

    参数      |     类型     |        描述       
    ----------- | ------------ | ---------------- 
    sourceAddress|NSString*|必填，发起该操作的源账户地址
    nonce|int64_t|必填，待发起的交易序列号，大小限制[1, max(int64)]
    operation|NSArray<BaseOperation *> *|必填，待提交的操作列表，不能为空
    signtureNumber|int32_t|选填，待签名者的数量，默认是1，大小限制[1, max(int32)]
    ceilLedgerSeq|int64_t|选填，距离当前区块高度指定差值的区块内执行的限制，当区块超出当时区块高度与所设差值的和后，交易执行失败。必须大于等于0，是0时不限制
    metadata|NSString*|选填，备注

- **响应数据**

    参数      |     类型     |        描述       
    ----------- | ------------ | ---------------- 
    txs     |   NSArray<[TestTx](#testtx) *> *     |  评估交易集   

- **错误码**

    异常       |     错误码   |   描述   
    -----------  | ----------- | -------- 
    INVALID_SOURCEADDRESS_ERROR|11002|Invalid sourceAddress
    INVALID_NONCE_ERROR|11045|Nonce must be between 1 and max(int64)
    OPERATIONS_EMPTY_ERROR|11051|Operations cannot be empty
    OPERATIONS_ONE_ERROR|11053|One of the operations cannot be resolved
    INVALID_SIGNATURENUMBER_ERROR|11054|SignagureNumber must be between 1 and max(int32)
    REQUEST_NULL_ERROR|12001|Request parameter cannot be null
    SYSTEM_ERROR|20000|System error

- **示例**

    ```objc
    // 初始化变量
    NSString* senderAddresss = @"buQfnVYgXuMo3rvCEpKA6SfRrDpaz8D8A9Ea";
    NSString* destAddress = @"buQsurH1M4rjLkfjzkxR9KXJ6jSu2r9xBNEw";
    int64_t buAmount = [Tools BU2MO : 10.9];
    int64_t gasPrice = 1000;
    int64_t feeLimit = [Tools BU2MO : 0.01];
    int64_t nonce = 1;

    // 构建sendBU操作
    BUSendOperation *operation = [BUSendOperation new];
    [operation setSourceAddress: senderAddresss];
    [operation setDestAddress: destAddress];
    [operation setAmount: buAmount];

    // 初始化评估交易请求参数
    TransactionEvaluateFeeRequest *request = [TransactionEvaluateFeeRequest new];
    [request addOperation : buSendOperation];
    [request setSourceAddress : senderAddresss];
    [request setNonce : nonce];
    [request setSignatureNumber : 1];
    [request setMetadata : @"evaluate fees"];

    // 调用evaluateFee接口
    TransactionService *transactionServer = [[[SDK sharedInstance] setUrl:@"http://seed1.bumotest.io:26002"] getTransactionService];
    TransactionEvaluateFeeResponse* response = [transactionServer evaluateFee : request];
    if (response.errorCode == 0) {
        NSLog(@"%@", [response.result yy_modelToJSONString]);
    }
    else {
        NSLog(@"error: %@", response.errorDesc);
    }
    ```

### sign

- **接口说明**

   该接口用于实现交易的签名。

- **调用方法**

  `TransactionSignResponse *) sign : (TransactionSignRequest *) transactionSignRequest;`

- **请求参数**

    参数      |     类型     |        描述       
    ----------- | ------------ | ---------------- 
    blob|NSString*|必填，待签名的交易Blob
    privateKeys|NSArray<NSString *> *|必填，私钥列表


- **响应数据**

    参数      |     类型     |        描述       
    ----------- | ------------ | ---------------- 
    signatures|[SignatureInfo](#signatureinfo)*| 签名后的数据列表

- **错误码**

    异常       |     错误码   |   描述   
    -----------  | ----------- | -------- 
    INVALID_BLOB_ERROR|11056|Invalid blob
    PRIVATEKEY_NULL_ERROR|11057|PrivateKeys cannot be empty
    PRIVATEKEY_ONE_ERROR|11058|One of privateKeys is invalid
    REQUEST_NULL_ERROR|12001|Request parameter cannot be null
    SYSTEM_ERROR|20000|System error

- **示例**

    ```objc
    // 初始化请求参数
    NSString* issuePrivateKey = @"privbyQCRp7DLqKtRFCqKQJr81TurTqG6UKXMMtGAmPG3abcM9XHjWvq";
    NSString* transactionBlob = @"0A246275516E6E5545425245773268423670574847507A77616E5837643238786B364B566370102118C0843D20E8073A56080712246275516E6E5545425245773268423670574847507A77616E5837643238786B364B566370522C0A24627551426A4A443142534A376E7A41627A6454656E416870466A6D7852564545746D78481080A9E08704";
    TransactionSignRequest *signRequest = [TransactionSignRequest new];
    [signRequest setBlob : transactionBlob];
    [signRequest addPrivateKey : issuePrivateKey];

    // 调用sign接口
    TransactionService *transactionServer = [[[SDK sharedInstance] setUrl:@"http://seed1.bumotest.io:26002"] getTransactionService];
    TransactionSignResponse * signResponse = [transactionServer sign : signRequest];
    if (signResponse.errorCode == 0) {
        NSLog(@"sign response: %@", [signResponse yy_modelToJSONString]);
    } else {
        NSLog(@"error: %@", signResponse.errorDesc);
        return;
    }
    ```

### submit

- **接口说明**

   该接口用于实现交易的提交。

- **调用方法**

  `TransactionSubmitResponse *) submit : (TransactionSubmitRequest *) transactionSubmitRequest;`

- **请求参数**

    参数      |     类型     |        描述       
    ----------- | ------------ | ---------------- 
    blob|NSString*|必填，交易blob
    signature|[SignatureInfo](#signatureinfo)|必填，签名列表

- **响应数据**

    参数      |     类型     |        描述       
    ----------- | ------------ | ---------------- 
    hash|NSString*|交易hash

- **错误码**

    异常       |     错误码   |   描述   
    -----------  | ----------- | -------- 
    INVALID_BLOB_ERROR|11056|Invalid blob
    SIGNATURE_EMPTY_ERROR|11067|The signatures cannot be empty
    REQUEST_NULL_ERROR|12001|Request parameter cannot be null
    SYSTEM_ERROR|20000|System error

- **示例**

    ```objc
    // 初始化请求参数
    NSString* transactionBlob = @"0A246275516E6E5545425245773268423670574847507A77616E5837643238786B364B566370102118C0843D20E8073A56080712246275516E6E5545425245773268423670574847507A77616E5837643238786B364B566370522C0A24627551426A4A443142534A376E7A41627A6454656E416870466A6D7852564545746D78481080A9E08704";
    SignatureInfo *signature = [SignatureInfo new];
    signature.signData = @"D2B5E3045F2C1B7D363D4F58C1858C30ABBBB0F41E4B2E18AF680553CA9C3689078E215C097086E47A4393BCA715C7A5D2C180D8750F35C6798944F79CC5000A";
    signature.publicKey = @"b0011765082a9352e04678ef38d38046dc01306edef676547456c0c23e270aaed7ffe9e31477";
    TransactionSubmitRequest *submitRequest = [TransactionSubmitRequest new];
    [submitRequest setTransactionBlob : transactionBlob];
    [submitRequest addSignature : signature];

    // 调用submit接口
    TransactionSubmitResponse *submitResponse = [transactionServer submit : submitRequest];
    if (submitResponse.errorCode == 0) {
        NSLog(@"submit response: %@", [submitResponse yy_modelToJSONString]);
    } else {
        NSLog(@"error: %@", submitResponse.errorDesc);
    }
    ```

### getInfo

- **接口说明**

   该接口用于实现根据交易hash查询交易。

- **调用方法**

  `TransactionGetInfoResponse *) getInfo : (TransactionGetInfoRequest *) transactionGetInfoRequest;`

- **请求参数**

    参数      |     类型     |        描述       
    ----------- | ------------ | ---------------- 
    hash|NSString*|交易hash

- **响应数据**

    参数      |     类型     |        描述       
    ----------- | ------------ | ---------------- 
    totalCount|int64_t|返回的总交易数
    transactions|NSArray<[TransactionHistory](#transactionhistory) *> *|交易内容

- **错误码**

    异常       |     错误码   |   描述   
    -----------  | ----------- | -------- 
    INVALID_HASH_ERROR|11055|Invalid transaction hash
    REQUEST_NULL_ERROR|12001|Request parameter cannot be null
    CONNECTNETWORK_ERROR|11007|Failed to connect to the network
    SYSTEM_ERROR|20000|System error

- **示例**

    ```objc
    // 初始化请求参数
    TransactionGetInfoRequest *request = [TransactionGetInfoRequest new];
    [request setHash: @"389d53e55929c997d22f25d3757b088e2e869403ac0f2d13712ba877762b3d45"];

    // 调用getInfo接口
    TransactionService *service = [[[SDK sharedInstance] setUrl: @"http://seed1.bumotest.io:26002"] getTransactionService];
    TransactionGetInfoResponse *response = [service getInfo: request];
    if (response.errorCode == 0) {
        NSLog(@"%@", [response.result yy_modelToJSONString]);
    }
    else {
        NSLog(@"error: %@", response.errorDesc);
    }
    ```

## 操作

操作是指在交易在要做的事情，在构建操作之前，需要构建操作。目前操作有10种，分别是 [AccountActivateOperation](#accountactivateoperation)、[AccountSetMetadataOperation](#accountsetmetadataoperation)、 [AccountSetPrivilegeOperation](#accountsetprivilegeoperation)、 [AssetIssueOperation](#assetissueoperation)、 [AssetSendOperation](#assetsendoperation)、 [BUSendOperation](#busendoperation)、 [ContractCreateOperation](#contractcreateoperation)、 [ContractInvokeByAssetOperation](#contractinvokebyassetoperation)、 [ContractInvokeByBUOperation](#contractinvokebybuoperation)、 [LogCreateOperation](#logcreateoperation)。

**BaseOperation**

BaseOperation是buildBlob接口中所有操作的基类。

成员变量    |     类型  |        描述                           
------------- | -------- | ----------------------------------   
sourceAddress | NSString* |  选填，操作源账户地址
metadata      | NSString* |  选填，备注

### AccountActivateOperation

- 功能

  该操作用于激活账户。AccountActivateOperation继承于BaseOperation。

- 费用

  FeeLimit目前(2018.07.26)固定是0.01 BU。

- 成员

   成员变量    |     类型  |        描述                           
   ------------- | -------- | ---------------------------------- 
   sourceAddress | NSString* |  选填，操作源账户地址 
   destAddress   | NSString* |  必填，目标账户地址                     
   initBalance   |   int64   |  必填，初始化资产，单位MO，1 BU = 10^8 MO, 大小(0, max(int64)] 
   metadata|NSString*|选填，备注

### AccountSetMetadataOperation

- 功能

  该操作用于设置账户metadata。AccountSetMetadataOperation继承于BaseOperation。

- 费用

  FeeLimit目前(2018.07.26)固定是0.01 BU。

- 成员

   成员变量    |     类型   |        描述                         
   ------------- | --------- | ------------------------------- 
   sourceAddress | NSString* |  选填，操作源账户地址
   key           | NSString*  |  必填，metadata的关键词，长度限制[1, 1024]
   value         | NSString*  |  必填，metadata的内容，长度限制[0, 256000]
   version       |   int64   |  选填，metadata的版本
   deleteFlag    |   Boolean |  选填，是否删除metadata
   metadata|NSString*|选填，备注           

### AccountSetPrivilegeOperation

- 功能

  该操作用于设置账户权限。AccountSetPrivilegeOperation继承于BaseOperation。

- 费用

  feeLimit目前(2018.07.26)固定是0.01 BU。

- 成员

   成员变量    |     类型   |        描述               
   ------------- | --------- | --------------------------
   sourceAddress | NSString* |  选填，操作源账户地址
   masterWeight|NSString*|选填，账户自身权重，大小限制[0, max(UINT32)]
   signers|[SignerInfo](#signerinfo)[]|选填，签名者权重列表
   txThreshold|NSString*|选填，交易门限，大小限制[0, max(int64)]
   typeThreshold|[TypeThreshold](#typethreshold)[]|选填，指定类型交易门限
   metadata|NSString*|选填，备注

### AssetIssueOperation

- 功能

  该操作用于发行资产。AssetIssueOperation继承于BaseOperation。

- 费用

  FeeLimit目前(2018.07.26)固定是50.01 BU。

- 成员

   成员变量    |     类型   |        描述             
   ------------- | --------- | ------------------------
   sourceAddress|NSString*|选填，操作源账户地址
   code|NSString*|必填，资产编码，长度限制[1, 64]
   assetAmount|int64|必填，资产发行数量，大小限制[0, max(int64)]
   metadata|NSString*|选填，备注

### AssetSendOperation

**注意**：若目标账户未激活，必须先调用激活账户操作。

- 功能

  该操作用于转移资产。AssetSendOperation继承于BaseOperation。

- 费用

  FeeLimit目前(2018.07.26)固定是0.01 BU。

- 成员

   成员变量    |     类型   |        描述            
   ------------- | --------- | ----------------------
   sourceAddress|NSString*|选填，操作源账户地址
   destAddress|NSString*|必填，目标账户地址
   code|NSString*|必填，资产编码，长度限制[1, 64]
   issuer|NSString*|必填，资产发行账户地址
   assetAmount|int64|必填，资产数量，大小限制[0, max(int64)]
   metadata|NSString*|选填，备注

### BUSendOperation

**注意**：若目标账户未激活，该操作也可使目标账户激活。

- 功能

  该操作用于转移BU。BUSendOperation继承于BaseOperation。

- 费用

  FeeLimit目前(2018.07.26)固定是0.01 BU。

- 成员

   成员变量    |     类型   |        描述          
   ------------- | --------- | ---------------------
   sourceAddress|NSString*|选填，操作源账户地址
   destAddress|NSString*|必填，目标账户地址
   buAmount|int64|必填，BU 数量，大小限制[0, max(int64)]
   metadata|NSString*|选填，备注

### ContractCreateOperation

- 功能

  该操作用于创建合约。ContractCreateOperation继承于BaseOperation。

- 费用

  FeeLimit目前(2018.07.26)固定是10.01 BU。

- 成员

   成员变量    |     类型   |        描述          
   ------------- | --------- | ---------------------
   sourceAddress|NSString*|选填，操作源账户地址
   initBalance|int64|必填，给合约账户的初始化资产，单位MO，1 BU = 10^8 MO, 大小限制[1, max(int64)]
   type|Integer|选填，合约的语种，默认是0
   payload|NSString*|必填，对应语种的合约代码
   initInput|NSString*|选填，合约代码中init方法的入参
   metadata|NSString*|选填，备注

### ContractInvokeByAssetOperation

**注意**：若合约账户不存在，必须先创建合约账户。

- 功能

  该操作用于转移资产并触发合约。ContractInvokeByAssetOperation继承于BaseOperation。

- 费用

  FeeLimit要根据合约中执行交易来做添加手续费，首先发起交易手续费目前(2018.07.26)是0.01BU，然后合约中的交易也需要交易发起者添加相应交易的手续费。

- 成员

   成员变量    |     类型   |        描述          
   ------------- | --------- | ---------------------
   sourceAddress|NSString*|选填，操作源账户地址
   contractAddress|NSString*|必填，合约账户地址
   code|NSString*|选填，资产编码，长度限制[0, 64];当为空时，仅触发合约;
   issuer|NSString*|选填，资产发行账户地址，当null时，仅触发合约
   assetAmount|int64|选填，资产数量，大小限制[0, max(int64)]，当是0时，仅触发合约
   input|NSString*|选填，待触发的合约的main()入参
   metadata|NSString*|选填，备注

### ContractInvokeByBUOperation

**注意**：若目标账户非合约账户且未激活，该操作也可使目标账户激活。

- 功能

  该操作用于转移BU并触发合约。ContractInvokeByBUOperation继承于BaseOperation。

- 费用

  FeeLimit要根据合约中执行交易来做添加手续费，首先发起交易手续费目前(2018.07.26)是0.01BU，然后合约中的交易也需要交易发起者添加相应交易的手续费。

- 成员

   成员变量    |     类型   |        描述          
   ------------- | --------- | ---------------------
   sourceAddress|NSString*|选填，操作源账户地址
   contractAddress|NSString*|必填，合约账户地址
   buAmount|int64|选填，BU 数量，大小限制[0, max(int64)]，当0时仅触发合约
   input|NSString*|选填，待触发的合约的main()入参
   metadata|NSString*|选填，备注

### LogCreateOperation

- 功能

  该操作用于记录日志。LogCreateOperation继承于BaseOperation。

- 费用

  FeeLimit目前(2018.07.26)固定是0.01 BU。

- 成员

   成员变量    |     类型   |        描述          
   ------------- | --------- | ---------------------
   sourceAddress|NSString*|选填，操作源账户地址
   topic|NSString*|必填，日志主题，长度限制[1, 128]
   datas|List<String>|必填，日志内容，每个字符串长度限制[1, 1024]
   metadata|NSString*|选填，备注


## 账户服务

账户服务主要是账户相关的接口，包括6个接口：`checkValid`、`getInfo`、`getNonce`、`getBalance`、`getAssets`、`getMetadata`。

### checkValid
- **接口说明**

   该接口用于检查区块链账户地址的有效性。

- **调用方法**

  `(AccountCheckValidResponse *) checkValid : (AccountCheckValidRequest *) accountCheckValidRequest;`

- **请求参数**

    参数      |     类型     |        描述       
    ----------- | ------------ | ---------------- 
    address     |   NSString*     |  必填，待检查的区块链账户地址   

- **响应数据**

    参数      |     类型     |        描述       
    ----------- | ------------ | ---------------- 
    isValid     |   BOOL     |  是否有效   

- **错误码**

    异常       |     错误码   |   描述   
    -----------  | ----------- | -------- 
    REQUEST_NULL_ERROR|12001|Request parameter cannot be null
    SYSTEM_ERROR |   20000     |  System error 

- **示例**

    ```objc
    // 初始化请求参数
    AccountService *accountService = [[[SDK sharedInstance] setUrl:@"http://seed1.bumotest.io:26002"] getAccountService];
    AccountCheckValidRequest *request = [AccountCheckValidRequest new];
    [request setAddress:@"buQnnUEBREw2hB6pWHGPzwanX7d28xk6KVcp"];

    // 调用checkValid接口
    AccountCheckValidResponse *response = [accountService checkValid: nil];
    if (response.errorCode == 0) {
        NSLog(@"%@", [response.result yy_modelToJSONString]);
    } else {
        NSLog(@"%@", response.errorDesc);
    }
    ```

### create
- **接口说明**

   该接口用于检查区块链账户地址的有效性。

- **调用方法**

  `(AccountCreateResponse *) create;`

- **响应数据**

    参数      |     类型     |        描述       
    ----------- | ------------ | ---------------- 
    privateKey   |   NSString *     |  私钥
    publicKey   |   NSString *     |  公钥
    address   |   NSString *     |  地址

- **错误码**

    异常       |     错误码   |   描述   
    -----------  | ----------- | -------- 
    SYSTEM_ERROR |   20000     |  System error 

- **示例**

    ```objc
    AccountService *accountService = [[[SDK sharedInstance] setUrl:@"http://seed1.bumotest.io:26002"] getAccountService];
    AccountCreateResponse *response = [accountService create];
    if (response.errorCode == 0) {
        NSLog(@"%@", [response.result yy_modelToJSONString]);
    } else {
        NSLog(@"%@", response.errorDesc);
    }
    ```

### getInfo

- **接口说明**

   该接口用于获取指定的账户信息。

- **调用方法**

  `(AccountGetInfoResponse *) getInfo : (AccountGetInfoRequest *) accountGetInfoRequest;`

- **请求参数**

    参数      |     类型     |        描述       
    ----------- | ------------ | ---------------- 
    address     |   NSString*     |  必填，待查询的区块链账户地址   

- **响应数据**

    参数    |     类型      |        描述       
    --------- | ------------- | ---------------- 
    address	  |    NSString*     |    账户地址       
    balance	  |    int64_t       |    账户余额，单位MO，1 BU = 10^8 MO, 必须大于0
    nonce	  |    int64_t       |    账户交易序列号，必须大于0
    priv	  | [Priv](#priv)* |    账户权限

- **错误码**

    异常       |     错误码   |   描述   
    -----------  | ----------- | -------- 
    INVALID_ADDRESS_ERROR| 11006 | Invalid address
    REQUEST_NULL_ERROR|12001|Request parameter cannot be null
    CONNECTNETWORK_ERROR| 11007| Failed to connect to the network
    SYSTEM_ERROR |   20000     |  System error 

- **示例**

    ```objc
    // 初始化请求参数
    NSString *address = @"buQnnUEBREw2hB6pWHGPzwanX7d28xk6KVcp";
    AccountService *accountService = [[[SDK sharedInstance] setUrl:@"http://seed1.bumotest.io:26002"] getAccountService];
    AccountGetInfoRequest *request = [AccountGetInfoRequest new];
    [request setAddress : address];

    // 调用getInfo接口
    AccountGetInfoResponse *response = [accountService getInfo : request];
    if (response.errorCode == 0) {
        NSLog(@"%@", [response.result yy_modelToJSONString]);
    } else {
        NSLog(@"%@", response.errorDesc);
    }
    ```

### getNonce

- **接口说明**

   该接口用于获取指定账户的nonce值。

- **调用方法**

  `(AccountGetNonceResponse *) getNonce : (AccountGetNonceRequest *) accountGetNonceRequest;`

- **请求参数**

    参数      |     类型     |        描述       
    ----------- | ------------ | ---------------- 
    address     |   NSString*     |  必填，待查询的区块链账户地址   

- **响应数据**

    参数      |     类型     |        描述       
    ----------- | ------------ | ---------------- 
    nonce       |   int64_t       |  账户交易序列号   

- **错误码**

    异常       |     错误码   |   描述   
    -----------  | ----------- | -------- 
    INVALID_ADDRESS_ERROR| 11006 | Invalid address
    REQUEST_NULL_ERROR|12001|Request parameter cannot be null
    CONNECTNETWORK_ERROR| 11007| Failed to connect to the network
    SYSTEM_ERROR |   20000     |  System error 

- **示例**

    ```objc
    // 初始化请求参数
    NSString *address = @"buQnnUEBREw2hB6pWHGPzwanX7d28xk6KVcp";
    AccountService *accountService = [[[SDK sharedInstance] setUrl:@"http://seed1.bumotest.io:26002"] getAccountService];
    AccountGetNonceRequest * request = [AccountGetNonceRequest new];
    [request setAddress : address];

    // 调用getNonce接口
    AccountGetNonceResponse *response = [accountService getNonce : request];
    if (response.errorCode == 0) {
        NSLog(@"%@", [response.result yy_modelToJSONString]);
    } else {
        NSLog(@"%@", response.errorDesc);
    }
    ```

### getBalance

- **接口说明**

   该接口用于获取指定账户的BU的余额。

- **调用方法**

  `(AccountGetBalanceResponse *) getBalance : (AccountGetBalanceRequest *) accountGetBalanceRequest;`

- **请求参数**

    参数      |     类型     |        描述       
    ----------- | ------------ | ---------------- 
    address     |   NSString*     |  必填，待查询的区块链账户地址   

- **响应数据**

    参数      |     类型     |        描述       
    ----------- | ------------ | ---------------- 
    balance     |   int64_t       |  BU的余额, 单位MO，1 BU = 10^8 MO 

- **错误码**

    异常       |     错误码   |   描述   
    -----------  | ----------- | -------- 
    INVALID_ADDRESS_ERROR| 11006 | Invalid address
    REQUEST_NULL_ERROR|12001|Request parameter cannot be null
    CONNECTNETWORK_ERROR| 11007| Failed to connect to the network
    SYSTEM_ERROR |   20000     |  System error 

- **示例**

    ```objc
    // 初始化请求参数
    NSString *address = @"buQnnUEBREw2hB6pWHGPzwanX7d28xk6KVcp";
    AccountService *accountService = [[[SDK sharedInstance] setUrl:@"http://seed1.bumotest.io:26002"] getAccountService];
    AccountGetBalanceRequest * request = [AccountGetBalanceRequest new];
    [request setAddress : address];

    // 调用getBalance接口
    AccountGetBalanceResponse *response = [accountService getBalance : request];
    if (response.errorCode == 0) {
        NSLog(@"%@", [response.result yy_modelToJSONString]);
    } else {
        NSLog(@"%@", response.errorDesc);
    }
    ```

### getAssets

- **接口说明**

   该接口用于获取指定账户的所有资产信息。

- **调用方法**

  `(AccountGetAssetsResponse *) getAssets : (AccountGetAssetsRequest *) accountGetAssetsRequest;`

- **请求参数**

    参数      |     类型     |        描述       
    ----------- | ------------ | ---------------- 
    address     |   NSString*     |  必填，待查询的账户地址   

- **响应数据**

    参数      |     类型     |        描述       
    ----------- | ------------ | ---------------- 
    asset	    | NSArray<[AssetInfo](#assetinfo) *> * |账户资产

- **错误码**

    异常       |     错误码   |   描述   
    -----------  | ----------- | -------- 
    INVALID_ADDRESS_ERROR| 11006 | Invalid address
    REQUEST_NULL_ERROR|12001|Request parameter cannot be null
    CONNECTNETWORK_ERROR| 11007| Failed to connect to the network
    NO_ASSET_ERROR|11009|The account does not have the asset
    SYSTEM_ERROR|20000|System error

- **示例**

    ```objc
    // 初始化请求参数
    NSString *address = @"buQhP94E8FjWDF3zfsxjqVQDeBypvzMrB3y3";
    AccountService *accountService = [[[SDK sharedInstance] setUrl:@"http://seed1.bumotest.io:26002"] getAccountService];
    AccountGetAssetsRequest * request = [AccountGetAssetsRequest new];
    [request setAddress : address];

    // 调用getAssets接口
    AccountGetAssetsResponse *response = [accountService getAssets : request];
    if (response.errorCode == 0) {
        //AssetInfo *assetInfo = [response.result.assets objectAtIndex : 0];
        //NSLog(@"%@, %@", assetInfo.key.code, assetInfo.key.issuer);
        NSLog(@"%@", [response.result yy_modelToJSONString]);
    } else {
        NSLog(@"%@", response.errorDesc);
    }
    ```

### getMetadata

- **接口说明**

   该接口用于获取指定账户的metadata信息。

- **调用方法**

  `(AccountGetMetadataResponse *) getMetadata : (AccountGetMetadataRequest *) accountGetMetadataRequest;`

- **请求参数**

    参数   |   类型   |        描述       
    -------- | -------- | ---------------- 
    address  |  NSString*  |  必填，待查询的账户地址  
    key      |  NSString*  |  选填，metadata关键字，长度限制[1, 1024]

- **响应数据**

    参数      |     类型    |        描述       
    ----------- | ----------- | ---------------- 
    metadata    |[MetadataInfo](#metadatainfo)*   |  账户

- **错误码**

    异常       |     错误码   |   描述   
    -----------  | ----------- | -------- 
    INVALID_ADDRESS_ERROR | 11006 | Invalid address
    REQUEST_NULL_ERROR|12001|Request parameter cannot be null
    CONNECTNETWORK_ERROR | 11007 | Failed to connect to the network
    NO_METADATA_ERROR|11010|The account does not have the metadata
    INVALID_DATAKEY_ERROR | 11011 | The length of key must be between 1 and 1024
    SYSTEM_ERROR | 20000| System error


- **示例**

    ```objc
    // 初始化请求参数
    NSString *address = @"buQhP94E8FjWDF3zfsxjqVQDeBypvzMrB3y3";
    AccountService *accountService = [[[SDK sharedInstance] setUrl:@"http://seed1.bumotest.io:26002"] getAccountService];
    AccountGetMetadataRequest * request = [AccountGetMetadataRequest new];
    [request setAddress : address];

    // 调用getMetadata接口
    AccountGetMetadataResponse *response = [accountService getMetadata : request];
    if (response.errorCode == 0) {
        //MetadataInfo *metadataInfo = [response.result.metadatas objectAtIndex:0];
        //NSLog(@"%@, %@. %lld", metadataInfo.key, metadataInfo.value, metadataInfo.version);
        NSLog(@"%@", [response.result yy_modelToJSONString]);
    } else {
        NSLog(@"%@", response.errorDesc);
    }
    ```

## 资产服务

遵循ATP1.0协议，账户服务主要是资产相关的接口，目前有1个接口：`getInfo`

### getInfo

- **接口说明**

   该接口用于获取指定账户的指定资产信息。

- **调用方法**

  `(AssetGetInfoResponse *) getInfo : (AssetGetInfoRequest *) assetGetRequest;`

- **请求参数**

   参数      |     类型     |        描述       
   ----------- | ------------ | ---------------- 
   address     |   NSString*    |  必填，待查询的账户地址
   code        |   NSString*    |  必填，资产编码，长度限制[1, 64]
   issuer      |   NSString*    |  必填，资产发行账户地址

- **响应数据**

   参数      |     类型     |        描述       
   ----------- | ------------ | ---------------- 
   asset	    | NSArray<[AssetInfo](#assetinfo) *> * |账户资产   

- **错误码**

   异常       |     错误码   |   描述   
   -----------  | ----------- | -------- 
   INVALID_ADDRESS_ERROR|11006|Invalid address
   REQUEST_NULL_ERROR|12001|Request parameter cannot be null
   CONNECTNETWORK_ERROR|11007|Failed to connect to the network
   INVALID_ASSET_CODE_ERROR|11023|The length of asset code must be between 1 and 64
   INVALID_ISSUER_ADDRESS_ERROR|11027|Invalid issuer address
   SYSTEM_ERROR|20000|System error

- **示例**

    ```objc
    // 初始化请求参数
    NSString *address = @"buQhP94E8FjWDF3zfsxjqVQDeBypvzMrB3y3";
    NSString *code = @"TST";
    NSString *issuer = @"buQhP94E8FjWDF3zfsxjqVQDeBypvzMrB3y3";
    AssetGetInfoRequest *request = [AssetGetInfoRequest new];
    [request setAddress : address];
    [request setCode : code];
    [request setIssuer : issuer];

    // 调用getInfo消息
    AssetService *assetService = [[[SDK sharedInstance] setUrl:@"http://seed1.bumotest.io:26002"] getAssetService];
    AssetGetInfoResponse *response = [assetService getInfo : request];
    if (response.errorCode == 0) {
        NSLog(@"%@", [response.result yy_modelToJSONString]);
    } else {
        NSLog(@"%@", response.errorDesc);
    }
    ```

## 合约服务

合约服务主要是合约相关的接口，目前有4个接口：`checkValid`、 `getInfo`、 `getAddress`、`call`

### checkValid

- **接口说明**

   该接口用于检测合约账户的有效性。

- **调用方法**

  `(ContractCheckValidResponse *) checkValid : (ContractCheckValidRequest *) contractCheckValidRequest;`

- **请求参数**

    参数      |     类型     |        描述       
    ----------- | ------------ | ---------------- 
    contractAddress     |   NSString*     |  待检测的合约账户地址   

- **响应数据**

    参数      |     类型     |        描述       
    ----------- | ------------ | ---------------- 
    isValid     |   BOOL     |  是否有效   

- **错误码**

    异常       |     错误码   |   描述   
    -----------  | ----------- | -------- 
    INVALID_CONTRACTADDRESS_ERROR|11037|Invalid contract address
    REQUEST_NULL_ERROR|12001|Request parameter cannot be null
    SYSTEM_ERROR |   20000     |  System error 

- **示例**

    ```objc
    // 初始化请求参数
    ContractCheckValidRequest *request = [ContractCheckValidRequest new];
    [request setContractAddress: @"buQfnVYgXuMo3rvCEpKA6SfRrDpaz8D8A9Ea"];

    // 调用checkValid接口
    ContractService *service = [[[SDK sharedInstance] setUrl: @"http://seed1.bumotest.io:26002"] getContractService];
    ContractCheckValidResponse *response = [service checkValid: request];
    if (response.errorCode == 0) {
        NSLog(@"%@", [response.result yy_modelToJSONString]);
    }
    else {
        NSLog(@"error: %@", response.errorDesc);
    }
    ```

### getInfo

- **接口说明**

   该接口用于查询合约代码。

- **调用方法**

  `(ContractGetInfoResponse *) getInfo : (ContractGetInfoRequest *) contractGetInfoRequest;`

- **请求参数**

    参数      |     类型     |        描述       
    ----------- | ------------ | ---------------- 
    contractAddress     |   NSString*     |  待查询的合约账户地址   

- **响应数据**

    参数      |     类型     |        描述       
    ----------- | ------------ | ---------------- 
    contract|[ContractInfo](#contractinfo)*|合约信息

- **错误码**

    异常       |     错误码   |   描述   
    -----------  | ----------- | -------- 
    INVALID_CONTRACTADDRESS_ERROR|11037|Invalid contract address
    CONTRACTADDRESS_NOT_CONTRACTACCOUNT_ERROR|11038|contractAddress is not a contract account
    NO_SUCH_TOKEN_ERROR|11030|No such token
    GET_TOKEN_INFO_ERROR|11066|Failed to get token info
    REQUEST_NULL_ERROR|12001|Request parameter cannot be null
    SYSTEM_ERROR|20000|System error

- **示例**

    ```objc
    // 初始化请求参数
    ContractGetInfoRequest *request = [ContractGetInfoRequest new];
    [request setContractAddress: @"buQfnVYgXuMo3rvCEpKA6SfRrDpaz8D8A9Ea"];

    // 调用getInfo接口
    ContractService *service = [[[SDK sharedInstance] setUrl: @"http://seed1.bumotest.io:26002"] getContractService];
    ContractGetInfoResponse *response = [service getInfo: request];
    if (response.errorCode == 0) {
        NSLog(@"%@", [response.result yy_modelToJSONString]);
    }
    else {
        NSLog(@"error: %@", response.errorDesc);
    }
    ```

### getAddress

- **接口说明**

  该接口用于查询合约地址。

- **调用方法**

  `(ContractGetAddressResponse *) getAddress : (ContractGetAddressRequest *) contractGetAddressRequest;`

- **请求参数**

    参数      |     类型     |        描述       
    ----------- | ------------ | ---------------- 
    hash     |   NSString*     |  创建合约交易的hash   

- **响应数据**

    参数      |     类型     |        描述       
    ----------- | ------------ | ---------------- 
    contractAddressList|NSArray<[ContractAddressInfo](#contractaddressinfo) *> *|合约地址列表

- **错误码**

    异常       |     错误码   |   描述   
    -----------  | ----------- | -------- 
    INVALID_HASH_ERROR|11055|Invalid transaction hash
    CONNECTNETWORK_ERROR|11007|Failed to connect to the network
    REQUEST_NULL_ERROR|12001|Request parameter cannot be null
    SYSTEM_ERROR|20000|System error

- **示例**

    ```objc
    // 初始化请求参数
    ContractGetAddressRequest *request = [ContractGetAddressRequest new];
    [request setHash: @"44246c5ba1b8b835a5cbc29bdc9454cdb9a9d049870e41227f2dcfbcf7a07689"];

    // 调用getAddress接口
    ContractService *service = [[[SDK sharedInstance] setUrl: @"http://seed1.bumotest.io:26002"] getContractService];
    ContractGetAddressResponse *response = [service getAddress: request];
    if (response.errorCode == 0) {
        NSLog(@"%@", [response.result yy_modelToJSONString]);
    }
    else {
        NSLog(@"error: %@", response.errorDesc);
    }
    ```

### call 

- **接口说明**

   该接口用于调试合约代码。

- **调用方法**

  `(ContractCallResponse *) call : (ContractCallRequest *) contractCallRequest;`

- **请求参数**

    参数      |     类型     |        描述       
    ----------- | ------------ | ---------------- 
    sourceAddress|NSString*|选填，合约触发账户地址
    contractAddress|NSString*|选填，合约账户地址，与code不能同时为空
    code|NSString*|选填，合约代码，与contractAddress不能同时为空
    input|NSString*|选填，合约入参
    contractBalance|int64_t|选填，赋予合约的初始 BU 余额, 单位MO，1 BU = 10^8 MO, 大小限制[1, max(int64)]
    optType|int32_t|必填，0: 调用合约的读写接口 init, 1: 调用合约的读写接口 main, 2 :调用只读接口 query
    feeLimit|int64_t|交易要求的最低手续费， 大小限制[1, max(int64)]
    gasPrice|int64_t|交易燃料单价，大小限制[1000, max(int64)]


- **响应数据**

    参数      |     类型     |        描述       
    ----------- | ------------ | ---------------- 
    logs|JSONObject|日志信息
    queryRets|JSONArray|查询结果集
    stat|[ContractStat](#contractstat)*|合约资源占用信息
    txs|NSArray<[TransactionEnvs](#transactionenvs) *> *|交易集

- **错误码**

    异常       |     错误码   |   描述   
    -----------  | ----------- | -------- 
    INVALID_SOURCEADDRESS_ERROR|11002|Invalid sourceAddress
    INVALID_CONTRACTADDRESS_ERROR|11037|Invalid contract address
    CONTRACTADDRESS_CODE_BOTH_NULL_ERROR|11063|ContractAddress and code cannot be empty at the same time
    INVALID_OPTTYPE_ERROR|11064|OptType must be between 0 and 2
    REQUEST_NULL_ERROR|12001|Request parameter cannot be null
    CONNECTNETWORK_ERROR|11007|Failed to connect to the network
    SYSTEM_ERROR|20000|System error

- **示例**

    ```objc
    // 初始化请求参数
    ContractCallRequest *request = [ContractCallRequest new];
    [request setCode : @"\"use strict\";log(undefined);function query() { getBalance(thisAddress); }"];
    [request setFeeLimit : 1000000000];
    [request setOptType : 2];

    // 调用call接口
    ContractService *service = [[[SDK sharedInstance] setUrl: @"http://seed1.bumotest.io:26002"] getContractService];
    ContractCallResponse *response = [service call : request];
    if (response.errorCode == 0) {
        NSLog(@"%@", [response.result yy_modelToJSONString]);
    }
    else {
        NSLog(@"error: %@", response.errorDesc);
    }
    ```


## 区块服务

区块服务主要是区块相关的接口，目前有11个接口：`getNumber`、`checkStatus`、`getTransactions`、`getInfo`、`etLatestInfo`、`getValidators`、`getLatestValidators`、`getReward`、`getLatestReward`、`getFees`、`getLatestFees`。

### getNumber

- **接口说明**

   该接口用于查询最新的区块高度。

- **调用方法**

  `(BlockGetNumberResponse *) getNumber;`

- **响应数据**

    参数      |     类型     |        描述       
    ----------- | ------------ | ---------------- 
    blockNumber|int64_t|最新的区块高度，对应底层字段seq

- **错误码**

    异常       |     错误码   |   描述   
    -----------  | ----------- | -------- 
    CONNECTNETWORK_ERROR|11007|Failed to connect to the network
    SYSTEM_ERROR|20000|System error

- **示例**

    ```objc
    BlockService *service = [[[SDK sharedInstance] setUrl: @"http://seed1.bumotest.io:26002"] getBlockService];
    BlockGetNumberResponse *response = [service getNumber];
    if (response.errorCode == 0) {
        NSLog(@"%@", [response.result yy_modelToJSONString]);
    }
    else {
        NSLog(@"error: %@", response.errorDesc);
    }
    ```

### checkStatus

- **接口说明**

   该接口用于检查本地节点区块是否同步完成。

- **调用方法**

  `(BlockCheckStatusResponse *) checkStatus;`

- **响应数据**

    参数      |     类型     |        描述       
    ----------- | ------------ | ---------------- 
    isSynchronous    |   BOOL     |  区块是否同步   

- **错误码**

    异常       |     错误码   |   描述   
    -----------  | ----------- | -------- 
    CONNECTNETWORK_ERROR|11007|Failed to connect to the network
    SYSTEM_ERROR|20000|System error

- **示例**

    ```objc
    // 调用checkStatus
    BlockService *service = [[[SDK sharedInstance] setUrl: @"http://seed1.bumotest.io:26002"] getBlockService];
    BlockCheckStatusResponse *response = [service checkStatus];
    if (response.errorCode == 0) {
        NSLog(@"%@", [response.result yy_modelToJSONString]);
    }
    else {
        NSLog(@"error: %@", response.errorDesc);
    }
    ```

### getTransactions

- **接口说明**

   该接口用于查询指定区块高度下的所有交易。

- **调用方法**

   `(BlockGetTransactionsResponse getTransactions(BlockGetTransactionsRequest);`

- **请求参数**

    参数      |     类型     |        描述       
    ----------- | ------------ | ---------------- 
    blockNumber|int64_t|必填，待查询的区块高度，必须大于0

- **响应数据**

    参数      |     类型     |        描述       
    ----------- | ------------ | ---------------- 
    totalCount|int64_t|返回的总交易数
    transactions|NSArray<[TransactionHistory](#transactionhistory) *> *|交易内容

- **错误码**

    异常       |     错误码   |   描述   
    -----------  | ----------- | -------- 
    INVALID_BLOCKNUMBER_ERROR|11060|BlockNumber must bigger than 0
    REQUEST_NULL_ERROR|12001|Request parameter cannot be null
    CONNECTNETWORK_ERROR|11007|Failed to connect to the network
    SYSTEM_ERROR|20000|System error

- **示例**

    ```objc
    // 初始化请求参数
    BlockGetTransactionsRequest *request = [BlockGetTransactionsRequest new];
    [request setBlockNumber: 617247];

    // 调用getTransactions接口
    BlockService *service = [[[SDK sharedInstance] setUrl: @"http://seed1.bumotest.io:26002"] getBlockService];
    BlockGetTransactionsResponse *response = [service getTransactions: request];
    if (response.errorCode == 0) {
        NSLog(@"%@", [response.result yy_modelToJSONString]);
    }
    else {
        NSLog(@"error: %@", response.errorDesc);
    }
    ```

### getInfo

- **接口说明**

   该接口用于获取区块信息。

- **调用方法**

  `(BlockGetInfoResponse *) getInfo : (BlockGetInfoRequest *) blockGetInfoRequest;`

- **请求参数**

    参数      |     类型     |        描述       
    ----------- | ------------ | ---------------- 
    blockNumber|int64_t|必填，待查询的区块高度

- **响应数据**

    参数      |     类型     |        描述       
    ----------- | ------------ | ---------------- 
    closeTime|int64_t|区块关闭时间
    number|int64_t|区块高度
    txCount|int64_t|交易总量
    version|NSString*|区块版本

- **错误码**

    异常       |     错误码   |   描述   
    -----------  | ----------- | -------- 
    INVALID_BLOCKNUMBER_ERROR|11060|BlockNumber must bigger than 0
    REQUEST_NULL_ERROR|12001|Request parameter cannot be null
    CONNECTNETWORK_ERROR|11007|Failed to connect to the network
    SYSTEM_ERROR|20000|System error

- **示例**

    ```objc
    // 初始化请求参数
    BlockGetInfoRequest *request = [BlockGetInfoRequest new];
    [request setBlockNumber: 617247];

    // 调用getInfo接口
    BlockService *service = [[[SDK sharedInstance] setUrl: @"http://seed1.bumotest.io:26002"] getBlockService];
    BlockGetInfoResponse *response = [service getInfo: request];
    if (response.errorCode == 0) {
        NSLog(@"%@", [response.result yy_modelToJSONString]);
    }
    else {
        NSLog(@"error: %@", response.errorDesc);
    }
    ```

### getLatestInfo

- **接口说明**

   该接口用于获取最新区块信息。

- **调用方法**

  `(BlockGetLatestInfoResponse *) getLatestInfo;`

- **响应数据**

    参数      |     类型     |        描述       
    ----------- | ------------ | ---------------- 
    closeTime|int64_t|区块关闭时间
    number|int64_t|区块高度，对应底层字段seq
    txCount|int64_t|交易总量
    version|NSString*|区块版本


- **错误码**

    异常       |     错误码   |   描述   
    -----------  | ----------- | -------- 
    CONNECTNETWORK_ERROR|11007|Failed to connect to the network
    SYSTEM_ERROR|20000|System error

- **示例**

    ```objc
    BlockService *service = [[[SDK sharedInstance] setUrl: @"http://seed1.bumotest.io:26002"] getBlockService];
    BlockGetLatestInfoResponse *response = [service getLatestInfo];
    if (response.errorCode == 0) {
        NSLog(@"%@", [response.result yy_modelToJSONString]);
    }
    else {
        NSLog(@"error: %@", response.errorDesc);
    }
    ```

### getValidators

- **接口说明**

   该接口用于获取指定区块中所有验证节点。

- **调用方法**

  `(BlockGetValidatorsResponse *) getValidators : (BlockGetValidatorsRequest *) blockGetValidatorsRequest;`

- **请求参数**

    参数      |     类型     |        描述       
    ----------- | ------------ | ---------------- 
    blockNumber|int64_t|必填，待查询的区块高度，必须大于0

- **响应数据**

    参数      |     类型     |        描述       
    ----------- | ------------ | ---------------- 
    validators|NSArray<NSString *> *|验证节点列表

- **错误码**

    异常       |     错误码   |   描述   
    -----------  | ----------- | -------- 
    INVALID_BLOCKNUMBER_ERROR|11060|BlockNumber must bigger than 0
    REQUEST_NULL_ERROR|12001|Request parameter cannot be null
    CONNECTNETWORK_ERROR|11007|Failed to connect to the network
    SYSTEM_ERROR|20000|System error

- **示例**

    ```objc
    // 初始化请求参数
    BlockGetValidatorsRequest *request = [BlockGetValidatorsRequest new];
    [request setBlockNumber: 617247];

    // 调用getValidators接口
    BlockService *service = [[[SDK sharedInstance] setUrl: @"http://seed1.bumotest.io:26002"] getBlockService];
    BlockGetValidatorsResponse *response = [service getValidators: request];
    if (response.errorCode == 0) {
        NSLog(@"%@", [response.result yy_modelToJSONString]);
    }
    else {
        NSLog(@"error: %@", response.errorDesc);
    }
    ```

### getLatestValidators

- **接口说明**

   该接口用于获取最新区块中所有验证节点。

- **调用方法**

  `(BlockGetLatestValidatorsResponse *) getLatestValidators;`

- **响应数据**

    参数      |     类型     |        描述       
    ----------- | ------------ | ---------------- 
    validators|NSArray<NSString *> *|验证节点列表

- **错误码**

    异常       |     错误码   |   描述   
    -----------  | ----------- | -------- 
    CONNECTNETWORK_ERROR|11007|Failed to connect to the network
    SYSTEM_ERROR|20000|System error

- **示例**

    ```objc
    BlockService *service = [[[SDK sharedInstance] setUrl: @"http://seed1.bumotest.io:26002"] getBlockService];
    BlockGetLatestValidatorsResponse *response = [service getLatestValidators];
    if (response.errorCode == 0) {
        NSLog(@"%@", [response.result yy_modelToJSONString]);
    }
    else {
        NSLog(@"error: %@", response.errorDesc);
    }
    ```

### getReward

- **接口说明**

   该接口用于获取指定区块中的区块奖励和验证节点奖励。

   注：不建议使用该接口，后期会删除该接口，建议使用 getLatestReward 接口。该接口的参数 blockNumber 无效，只获取最新的区块奖励，与 getLatestReward 功接口能一样。

- **调用方法**

  `(BlockGetRewardResponse *) getReward : (BlockGetRewardRequest *) blockGetRewardRequest;`

- **请求参数**

    参数      |     类型     |        描述       
    ----------- | ------------ | ---------------- 
    blockNumber|int64_t|必填，待查询的区块高度，必须大于0

- **响应数据**

    参数      |     类型     |        描述       
    ----------- | ------------ | ---------------- 
     validators | NSArray<[Rewards](#Rewards) *> * | 验证节点奖励情况 
     kols       | NSArray<[Rewards](#Rewards) *> * | 生态节点奖励情况 

- **错误码**

    异常       |     错误码   |   描述   
    -----------  | ----------- | -------- 
    INVALID_BLOCKNUMBER_ERROR|11060|BlockNumber must bigger than 0
    REQUEST_NULL_ERROR|12001|Request parameter cannot be null
    CONNECTNETWORK_ERROR|11007|Failed to connect to the network
    SYSTEM_ERROR|20000|System error

- **示例**

    ```objc
    // 初始化请求参数
    BlockGetRewardRequest *request = [BlockGetRewardRequest new];
    [request setBlockNumber: 617247];

    // 调用getReward接口
    BlockService *service = [[[SDK sharedInstance] setUrl: @"http://seed1.bumotest.io:26002"] getBlockService];
    BlockGetRewardResponse *response = [service getReward: request];
    if (response.errorCode == 0) {
        NSLog(@"%@", [response.result yy_modelToJSONString]);
    }
    else {
        NSLog(@"error: %@", response.errorDesc);
    }
    ```

### getLatestReward

- **接口说明**

   获取最新区块中的区块奖励和验证节点奖励。

- **调用方法**

  `(BlockGetLatestRewardResponse *) getLatestReward;`

- **响应数据**

    参数      |     类型     |        描述       
    ----------- | ------------ | ---------------- 
     validators | NSArray<[Rewards](#Rewards) *> * | 验证节点奖励情况 
     kols       | NSArray<[Rewards](#Rewards) *> * |生态节点奖励情况

- **错误码**

    异常       |     错误码   |   描述   
    -----------  | ----------- | -------- 
    CONNECTNETWORK_ERROR|11007|Failed to connect to the network
    SYSTEM_ERROR|20000|System error

- **示例**

    ```objc
    BlockService *service = [[[SDK sharedInstance] setUrl: @"http://seed1.bumotest.io:26002"] getBlockService];
    BlockGetLatestRewardResponse *response = [service getLatestReward];
    if (response.errorCode == 0) {
        NSLog(@"%@", [response.result yy_modelToJSONString]);
    }
    else {
        NSLog(@"error: %@", response.errorDesc);
    }
    ```

### getFees

- **接口说明**

   获取指定区块中的账户最低资产限制和燃料单价。

- **调用方法**

  `(BlockGetFeesResponse *) getFees : (BlockGetFeesRequest *) blockGetFeesRequest;`

- **请求参数**

    参数      |     类型     |        描述       
    ----------- | ------------ | ---------------- 
    blockNumber|int64_t|必填，待查询的区块高度，必须大于0

- **响应数据**

    参数      |     类型     |        描述       
    ----------- | ------------ | ---------------- 
    fees|[Fees](#fees)*|费用

- **错误码**

    异常       |     错误码   |   描述   
    -----------  | ----------- | -------- 
    INVALID_BLOCKNUMBER_ERROR|11060|BlockNumber must bigger than 0
    REQUEST_NULL_ERROR|12001|Request parameter cannot be null
    CONNECTNETWORK_ERROR|11007|Failed to connect to the network
    SYSTEM_ERROR|20000|System error

- **示例**

    ```objc
    // 初始化请求参数
    BlockGetFeesRequest *request = [BlockGetFeesRequest new];
    [request setBlockNumber: 617247];

    // 调用getFees接口
    BlockService *service = [[[SDK sharedInstance] setUrl: @"http://seed1.bumotest.io:26002"] getBlockService];
    BlockGetFeesResponse *response = [service getFees: request];
    if (response.errorCode == 0) {
        NSLog(@"%@", [response.result yy_modelToJSONString]);
    }
    else {
        NSLog(@"error: %@", response.errorDesc);
    }
    ```

### getLatestFees

- **接口说明**

   该接口用于获取最新区块中的账户最低资产限制和燃料单价。

- **调用方法**

  `(BlockGetLatestFeesResponse *) getLatestFees;`

- **响应数据**

    参数      |     类型     |        描述       
    ----------- | ------------ | ---------------- 
    fees|[Fees](#fees)*|费用

- **错误码**

    异常       |     错误码   |   描述   
    -----------  | ----------- | -------- 
    CONNECTNETWORK_ERROR|11007|Failed to connect to the network
    SYSTEM_ERROR|20000|System error

- **示例**

    ```objc
    BlockService *service = [[[SDK sharedInstance] setUrl: @"http://seed1.bumotest.io:26002"] getBlockService];
    BlockGetLatestFeesResponse *response = [service getLatestFees];
    if (response.errorCode == 0) {
        NSLog(@"%@", [response.result yy_modelToJSONString]);
    }
    else {
        NSLog(@"error: %@", response.errorDesc);
    }
    ```

## 数据对象
#### Priv

成员    |     类型   |        描述       
-----------  | ------------ | ---------------- 
masterWeight |	 int64_t	    |   账户自身权重，大小限制[0, max(uint32)]
signers	     |NSArray<[SignerInfo](#signerinfo) *> *|   签名者权重列表
threshold	 |[Threshold](#threshold)*|	门限

#### SignerInfo

成员    |     类型   |        描述       
-----------  | ------------ | ---------------- 
address	     |   NSString*	    |   签名者区块链账户地址
weight	     |   int64_t	    |   签名者权重，大小限制[0, max(uint32)]

#### Threshold

成员    |     类型   |        描述       
-----------  | ------------ | ---------------- 
txThreshold	 |    int64_t	    |   交易默认门限，大小限制[0, max(int64)]
typeThresholds|NSArray<[TypeThreshold](#typethreshold) *> *|不同类型交易的门限

#### TypeThreshold

成员    |     类型   |        描述       
-----------  | ------------ | ---------------- 
type         |    int64_t	    |    操作类型，必须大于0
threshold    |    int64_t      |    门限值，大小限制[0, max(int64)]

#### AssetInfo

成员    |     类型   |        描述       
----------- | ------------ | ---------------- 
key       | [AssetKeyInfo](#assetkeyinfo)*  | 资产惟一标识
assetAmount    | int64_t        | 资产数量

 #### AssetKeyInfo

成员   |     类型    |     描述       
-------- | ----------- | -----------
code     |   NSString*    |   资产编码
issuer   |   NSString*    |   资产发行账户地址

#### MetadataInfo
成员      |     类型    |        描述       
----------- | ----------- | ---------------- 
key         |  NSString*     |  metadata的关键词
value       |  NSString*     |  metadata的内容
version     |  int64_t      |  metadata的版本

#### ContractInfo

成员    |     类型   |        描述       
----------- | ------------ | ---------------- 
type|int32_t|合约类型，默认0
payload|NSString*|合约代码

#### ContractAddressInfo

成员      |     类型     |        描述       
----------- | ------------ | ---------------- 
contractAddress|NSString*|合约地址
operationIndex|int32_t|所在操作的下标

#### ContractStat

成员    |     类型   |        描述       
----------- | ------------ | ---------------- 
applyTime|int64_t|接收时间
memoryUsage|int64_t|内存占用量
stackUsage|int64_t|堆栈占用量
step|int64_t|几步完成

#### TransactionEnvs

成员    |     类型   |        描述       
----------- | ------------ | ---------------- 
transactionEnv|[TransactionEnv](#transactionenv)*|交易

#### TransactionEnv

成员    |     类型   |        描述       
----------- | ------------ | ---------------- 
transaction|[TransactionInfo](#transactioninfo)*|交易内容
trigger|[ContractTrigger](#contracttrigger)*|合约触发者

#### TransactionInfo

成员    |     类型   |        描述       
----------- | ------------ | ---------------- 
sourceAddress|NSString*|交易发起的源账户地址
feeLimit|int64_t|交易要求的最低费用
gasPrice|int64_t|交易燃料单价
nonce|int64_t|交易序列号
operations|NSArray<[OperationInfo](#operationinfo) *> *|操作列表

#### ContractTrigger
成员    |     类型   |        描述       
----------- | ------------ | ---------------- 
transaction|[TriggerTransaction](#triggertransaction)*|触发交易

#### OperationInfo

成员    |     类型   |        描述       
----------- | ------------ | ---------------- 
type|int32_t|操作类型
sourceAddress|NSString*|操作发起源账户地址
metadata|NSString*|备注
createAccount|[OperationCreateAccount](#operationcreateaccount)*|创建账户操作
issueAsset|[OperationIssueAsset](#operationissueasset)*|发行资产操作
payAsset|[OperationPayAsset](#operationpayasset)*|转移资产操作
payCoin|[OperationPayCoin](#operationpaycoin)*|发送BU操作
setMetadata|[OperationSetMetadata](#operationsetmetadata)*|设置metadata操作
setPrivilege|[OperationSetPrivilege](#operationsetprivilege)*|设置账户权限操作
log|[OperationLog](#operationlog)*|记录日志

#### TriggerTransaction

成员    |     类型   |        描述       
----------- | ------------ | ---------------- 
hash|NSString*|交易hash

#### OperationCreateAccount

成员    |     类型   |        描述       
----------- | ------------ | ---------------- 
destAddress|NSString*|目标账户地址
contract|[Contract](#contract)*|合约信息
priv|[Priv](#priv)*|账户权限
metadata|NSArray<[MetadataInfo](#metadatainfo) *> *|账户
initBalance|int64_t|账户资产, 单位MO，1 BU = 10^8 MO, 
initInput|NSString*|合约init函数的入参

#### Contract

成员    |     类型   |        描述       
----------- | ------------ | ---------------- 
type|int32_t|约的语种，默认不赋值
payload|NSString*|对应语种的合约代码

#### MetadataInfo

成员    |     类型   |        描述       
----------- | ------------ | ---------------- 
key|NSString*|metadata的关键词
value|NSString*|metadata的内容
version|int64_t|metadata的版本

#### OperationIssueAsset

成员    |     类型   |        描述       
----------- | ------------ | ---------------- 
code|NSString*|资产编码
assetAmount|int64_t|资产数量

#### OperationPayAsset

成员    |     类型   |        描述       
----------- | ------------ | ---------------- 
destAddress|NSString*|待转移的目标账户地址
asset|[AssetInfo](#assetinfo)*|账户资产
input|NSString*|合约main函数入参

#### OperationPayCoin

成员    |     类型   |        描述       
----------- | ------------ | ---------------- 
destAddress|NSString*|待转移的目标账户地址
buAmount|int64_t|待转移的BU数量
input|NSString*|合约main函数入参

#### OperationSetMetadata

成员    |     类型   |        描述       
----------- | ------------ | ---------------- 
key|NSString*|metadata的关键词
value|NSString*|metadata的内容
version|int64_t|metadata的版本
deleteFlag|boolean|是否删除metadata

#### OperationSetPrivilege

成员    |     类型   |        描述       
----------- | ------------ | ---------------- 
masterWeight|NSString*|账户自身权重，大小限制[0, max(uint32)]
signers|NSArray<[SignerInfo](#signerinfo) *> *|签名者权重列表
txThreshold|NSString*|交易门限，大小限制[0, max(int64)]
typeThreshold|[TypeThreshold](#typethreshold)*|指定类型交易门限

#### OperationLog

成员    |     类型   |        描述       
----------- | ------------ | ---------------- 
topic|NSString*|日志主题
data|NSArray<NSString *> *|日志内容

#### TestTx

成员      |     类型     |        描述       
----------- | ------------ | ---------------- 
transactionEnv| [TestTransactionFees](#testtransactionfees)*| 评估交易费用

#### TestTransactionFees

成员      |     类型     |      描述      
----------- | ------------ | ---------------- 
transactionFees|[TransactionFees](#transactionfees)*|交易费用

#### TransactionFees
成员      |     类型     |        描述    
----------- | ------------ | ---------------- 
feeLimit|int64_t|交易要求的最低费用
gasPrice|int64_t|交易燃料单价

#### SignatureInfo

成员      |     类型     |        描述       
----------- | ------------ | ---------------- 
signData|int64_t|签名后数据
publicKey|int64_t|公钥

#### TransactionHistory

成员  |     类型     |        描述       
----------- | ------------ | ---------------- 
actualFee|NSString*|交易实际费用
closeTime|int64_t|交易关闭时间
errorCode|int64_t|交易错误码
errorDesc|NSString*|交易描述
hash|NSString*|交易hash
ledgerSeq|int64_t|区块序列号
transaction|[TransactionInfo](#transactioninfo)*|交易内容列表
signatures|NSArray<[SignatureInfo](#signatureinfo) *> *|签名列表
txSize|int64_t|交易大小

#### ValidatorInfo

成员  |     类型     |        描述       
----------- | ------------ | ---------------- 
address|NSString*|共识节点地址

#### Rewards

| Member  | Type      | Description |
| ------- | --------- | ----------- |
| address | NSString* | 节点地址    |
| reward  | NSArray*  | 节点奖励    |

#### ValidatorReward

成员  |     类型     |        描述       
----------- | ------------ | ---------------- 
  validator|NSString*|验证节点地址
  reward|int64_t|验证节点奖励

#### Fees

成员  |     类型     |        描述       
----------- | ------------ | ---------------- 
baseReserve|int64_t|账户最低资产限制
gasPrice|int64_t|交易燃料单价，单位MO，1 BU = 10^8 MO

## 错误码

异常       |     错误码   |   描述   
-----------  | ----------- | -------- 
ACCOUNT_CREATE_ERROR|11001|Failed to create the account 
INVALID_SOURCEADDRESS_ERROR|11002|Invalid sourceAddress
INVALID_DESTADDRESS_ERROR|11003|Invalid destAddress
INVALID_INITBALANCE_ERROR|11004|InitBalance must be between 1 and max(int64) 
SOURCEADDRESS_EQUAL_DESTADDRESS_ERROR|11005|SourceAddress cannot be equal to destAddress
INVALID_ADDRESS_ERROR|11006|Invalid address
CONNECTNETWORK_ERROR|11007|Failed to connect to the network
INVALID_ISSUE_AMOUNT_ERROR|11008|Amount of the token to be issued must be between 1 and max(int64)
NO_ASSET_ERROR|11009|The account does not have the asset
NO_METADATA_ERROR|11010|The account does not have the metadata
INVALID_DATAKEY_ERROR|11011|The length of key must be between 1 and 1024
INVALID_DATAVALUE_ERROR|11012|The length of value must be between 0 and 256000
INVALID_DATAVERSION_ERROR|11013|The version must be equal to or greater than 0 
INVALID_MASTERWEIGHT_ERROR|11015|MasterWeight must be between 0 and max(uint32)
INVALID_SIGNER_ADDRESS_ERROR|11016|Invalid signer address
INVALID_SIGNER_WEIGHT_ERROR|11017|Signer weight must be between 0 and max(uint32)
INVALID_TX_THRESHOLD_ERROR|11018|TxThreshold must be between 0 and max(int64)
INVALID_OPERATION_TYPE_ERROR|11019|Operation type must be between 1 and 100
INVALID_TYPE_THRESHOLD_ERROR|11020|TypeThreshold must be between 0 and max(int64)
INVALID_ASSET_CODE_ERROR|11023|The length of asset code must be between 1 and 64
INVALID_ASSET_AMOUNT_ERROR|11024|AssetAmount must be between 0 and max(int64)
INVALID_BU_AMOUNT_ERROR|11026|BuAmount must be between 0 and max(int64)
INVALID_ISSUER_ADDRESS_ERROR|11027|Invalid issuer address
NO_SUCH_TOKEN_ERROR|11030|No such token
INVALID_TOKEN_NAME_ERROR|11031|The length of token name must be between 1 and 1024
INVALID_TOKEN_SIMBOL_ERROR|11032|The length of symbol must be between 1 and 1024
INVALID_TOKEN_DECIMALS_ERROR|11033|Decimals must be between 0 and 8
INVALID_TOKEN_TOTALSUPPLY_ERROR|11034|TotalSupply must be between 1 and max(int64)
INVALID_TOKENOWNER_ERRPR|11035|Invalid token owner
INVALID_CONTRACTADDRESS_ERROR|11037|Invalid contract address
CONTRACTADDRESS_NOT_CONTRACTACCOUNT_ERROR|11038|contractAddress is not a contract account
INVALID_TOKEN_AMOUNT_ERROR|11039|TokenAmount must be between 1 and max(int64)
SOURCEADDRESS_EQUAL_CONTRACTADDRESS_ERROR|11040|SourceAddress cannot be equal to contractAddress
INVALID_FROMADDRESS_ERROR|11041|Invalid fromAddress
FROMADDRESS_EQUAL_DESTADDRESS_ERROR|11042|FromAddress cannot be equal to destAddress
INVALID_SPENDER_ERROR|11043|Invalid spender
PAYLOAD_EMPTY_ERROR|11044|Payload cannot be empty
INVALID_LOG_TOPIC_ERROR|11045|The length of a log topic must be between 1 and 128
INVALID_LOG_DATA_ERROR|11046|The length of one piece of log data must be between 1 and 1024
INVALID_CONTRACT_TYPE_ERROR|11047|Invalid contract type
INVALID_NONCE_ERROR|11048|Nonce must be between 1 and max(int64)
INVALID_GASPRICE_ERROR|11049|GasPrice must be between 1000 and max(int64)
INVALID_FEELIMIT_ERROR|11050|FeeLimit must be between 1 and max(int64)
OPERATIONS_EMPTY_ERROR|11051|Operations cannot be empty
INVALID_CEILLEDGERSEQ_ERROR|11052|CeilLedgerSeq must be equal to or greater than 0
OPERATIONS_ONE_ERROR|11053|One of the operations cannot be resolved
INVALID_SIGNATURENUMBER_ERROR|11054|SignagureNumber must be between 1 and max(int32)
INVALID_HASH_ERROR|11055|Invalid transaction hash
INVALID_BLOB_ERROR|11056|Invalid blob
PRIVATEKEY_NULL_ERROR|11057|PrivateKeys cannot be empty
PRIVATEKEY_ONE_ERROR|11058|One of privateKeys is invalid
SIGNDATA_NULL_ERROR|11059|SignData cannot be empty
INVALID_BLOCKNUMBER_ERROR|11060|BlockNumber must be bigger than 0
PUBLICKEY_NULL_ERROR|11061|PublicKey cannot be empty
URL_EMPTY_ERROR|11062|Url cannot be empty
CONTRACTADDRESS_CODE_BOTH_NULL_ERROR|11063|ContractAddress and code cannot be empty at the same time
INVALID_OPTTYPE_ERROR|11064|OptType must be between 0 and 2
GET_ALLOWANCE_ERROR|11065|Failed to get allowance
GET_TOKEN_INFO_ERROR|11066|Failed to get token info
SIGNATURE_EMPTY_ERROR|11067|The signatures cannot be empty
REQUEST_NULL_ERROR|12001|Request parameter cannot be null
CONNECTN_BLOCKCHAIN_ERROR|19999|Failed to connect to the blockchain 
SYSTEM_ERROR|20000|System error
