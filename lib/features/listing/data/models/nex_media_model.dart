class NexMediaModel {
  NexMediaModel({
    this.id,
    this.likes,
    this.shares,
    this.views,
    this.type,
    this.publishDate,
    this.publishTime,
    this.status,
    this.title,
    this.content,
    this.metaKeywords,
    this.metaTags,
    this.images,
    this.image,
    this.module,
    this.moduleCategory,
    this.moduleSection,
    this.moduleSpecialization,
    this.moduleService,
    this.modulePartner,
    this.followable,
    this.liked,
    this.comments,
  });

  NexMediaModel.fromJson(dynamic json) {
    id = json['id'];
    likes = json['likes'];
    shares = json['shares'];
    views = json['views'];
    type = json['type'];
    publishDate = json['publish_date'];
    publishTime = json['publish_time'];
    status = json['status'];
    title = json['title'];
    content = json['content'];
    metaKeywords = json['meta_keywords'] != null
        ? json['meta_keywords'].cast<String>()
        : [];
    metaTags =
        json['meta_tags'] != null ? json['meta_tags'].cast<String>() : [];
    images = json['images'] != null ? json['images'].cast<String>() : [];
    image = json['image'];
    module = json['module'] != null ? Module.fromJson(json['module']) : null;
    moduleCategory = json['module_category'] != null
        ? ModuleCategory.fromJson(json['module_category'])
        : null;
    moduleSection = json['module_section'] != null
        ? ModuleSection.fromJson(json['module_section'])
        : null;
    moduleSpecialization = json['module_specialization'];
    moduleService = json['module_service'];
    modulePartner = json['module_partner'];
    followable = json['followable'];
    liked = json['liked'] is bool ? json['liked'] : true;
    comments =
        json['comments'] != null ? Comments.fromJson(json['comments']) : null;
  }
  num? id;
  num? likes;
  num? shares;
  num? views;
  String? type;
  String? publishDate;
  String? publishTime;
  num? status;
  String? title;
  String? content;
  List<String>? metaKeywords;
  List<String>? metaTags;
  List<String>? images;
  String? image;
  Module? module;
  ModuleCategory? moduleCategory;
  ModuleSection? moduleSection;
  dynamic moduleSpecialization;
  dynamic moduleService;
  dynamic modulePartner;
  bool? followable;
  bool? liked;
  Comments? comments;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['likes'] = likes;
    map['shares'] = shares;
    map['views'] = views;
    map['type'] = type;
    map['publish_date'] = publishDate;
    map['publish_time'] = publishTime;
    map['status'] = status;
    map['title'] = title;
    map['content'] = content;
    map['meta_keywords'] = metaKeywords;
    map['meta_tags'] = metaTags;
    map['images'] = images;
    map['image'] = image;
    if (module != null) {
      map['module'] = module?.toJson();
    }
    if (moduleCategory != null) {
      map['module_category'] = moduleCategory?.toJson();
    }
    if (moduleSection != null) {
      map['module_section'] = moduleSection?.toJson();
    }
    map['module_specialization'] = moduleSpecialization;
    map['module_service'] = moduleService;
    map['module_partner'] = modulePartner;
    map['followable'] = followable;
    map['liked'] = liked;
    if (comments != null) {
      map['comments'] = comments?.toJson();
    }
    return map;
  }
}

class Comments {
  Comments({
    this.count,
    this.data,
  });

  Comments.fromJson(dynamic json) {
    count = json['count'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(CommentData.fromJson(v));
      });
    }
  }
  num? count;
  List<CommentData>? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['count'] = count;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class CommentData {
  CommentData({
    this.id,
    this.images,
    this.content,
    this.replies,
    this.creator,
  });

  CommentData.fromJson(dynamic json) {
    id = json['id'];
    images = json['images'] != null ? json['images'].cast<String>() : [];
    content = json['content'];
    replies = json['replies'];
    creator =
        json['creator'] != null ? Creator.fromJson(json['creator']) : null;
  }
  num? id;
  List<String>? images;
  String? content;
  num? replies;
  Creator? creator;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['images'] = images;
    map['content'] = content;
    map['replies'] = replies;
    if (creator != null) {
      map['creator'] = creator?.toJson();
    }
    return map;
  }
}

class Creator {
  Creator({
    this.id,
    this.name,
    this.image,
  });

  Creator.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }
  num? id;
  dynamic name;
  String? image;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['image'] = image;
    return map;
  }
}

class ModuleSection {
  ModuleSection({
    this.id,
    this.title,
  });

  ModuleSection.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
  }
  num? id;
  String? title;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    return map;
  }
}

class ModuleCategory {
  ModuleCategory({
    this.id,
    this.title,
  });

  ModuleCategory.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
  }
  num? id;
  String? title;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    return map;
  }
}

class Module {
  Module({
    this.id,
    this.title,
    this.slug,
    this.icon,
    this.image,
  });

  Module.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
    slug = json['slug'];
    icon = json['icon'];
    image = json['image'];
  }
  num? id;
  String? title;
  String? slug;
  String? icon;
  String? image;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    map['slug'] = slug;
    map['icon'] = icon;
    map['image'] = image;
    return map;
  }
}
