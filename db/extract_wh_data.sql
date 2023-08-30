SELECT rowid, * FROM 
(
  SELECT DISTINCT
    invTypes.typeName AS name,
    in_class,
    maxStableTime,
    maxStableMass,
    massRegeneration,
    maxJumpMass
  FROM 
    invTypes 
    LEFT JOIN (SELECT typeId, valueFloat AS in_class         FROM dgmTypeAttributes WHERE attributeId == 1381) USING (typeId)
    LEFT JOIN (SELECT typeId, valueFloat AS maxStableTime    FROM dgmTypeAttributes WHERE attributeId == 1382) USING (typeId)
    LEFT JOIN (SELECT typeId, valueFloat AS maxStableMass    FROM dgmTypeAttributes WHERE attributeId == 1383) USING (typeId)
    LEFT JOIN (SELECT typeId, valueFloat AS massRegeneration FROM dgmTypeAttributes WHERE attributeId == 1384) USING (typeId)
    LEFT JOIN (SELECT typeId, valueFloat AS maxJumpMass      FROM dgmTypeAttributes WHERE attributeId == 1385) USING (typeId)
  WHERE invTypes.groupId == 988;
)
