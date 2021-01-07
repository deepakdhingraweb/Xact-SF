public with sharing class FileUploadController {
    
    //To get the image
    @AuraEnabled(cacheable=true)
        public static string getProfilePicture(Id imageId) {
        Attachment a= [SELECT Id, Name, LastModifiedDate, ContentType FROM Attachment 
                WHERE parentid=:imageId AND ContentType IN ('image/png', 'image/jpeg', 'image/gif') 
                ORDER BY LastModifiedDate DESC LIMIT 1];
                system.debug(a);
        return a.Id;
    }
    
    //To save the image
    @AuraEnabled
    public static Id saveAttachment(Id imageId, String fileName, String base64Data, String contentType) { 
        base64Data = EncodingUtil.urlDecode(base64Data, 'UTF-8');
        Attachment attachment = new Attachment();
        attachment.parentId = imageId;
        attachment.body = EncodingUtil.base64Decode(base64Data);
        attachment.name = fileName;
        attachment.contentType = contentType;
        System.debug('Attact'+attachment);
        insert attachment;
        return attachment.id;
    }
    
}