# This is an auto-generated Django model module.
# You'll have to do the following manually to clean this up:
#   * Rearrange models' order
#   * Make sure each model has one field with primary_key=True
#   * Make sure each ForeignKey and OneToOneField has `on_delete` set to the desired behavior
#   * Remove `managed = False` lines if you wish to allow Django to create, modify, and delete the table
# Feel free to rename the models, but don't rename db_table values or field names.
from django.db import models


class Background(models.Model):
    bg_name = models.CharField(max_length=20, primary_key = True)
    bg_race = models.CharField(max_length=15)
    bg_age = models.IntegerField(default=0)
    bg_alignment = models.CharField(max_length=20)

    def __str__(self):
        return self.bg_name

    class Meta:
        db_table = 'background'


class Class(models.Model):
    cl_id = models.IntegerField(default=0)
    cl_name = models.CharField(max_length=15, primary_key = True)

    def __str__(self):
        return self.cl_name

    class Meta:
        db_table = 'class'


class Classspell(models.Model):
    clsp_ability = models.CharField(max_length=3)
    clsp_id = models.IntegerField(default=0)
    clsp_name = models.CharField(max_length=25)

    def __str__(self):
        return self.clsp_id + ' ' + self.clsp_name

    class Meta:
        db_table = 'classSpell'


class Classweapon(models.Model):
    clwpn_prof = models.CharField(max_length=1)
    clwpn_name = models.CharField(max_length=25)
    clwpn_id = models.IntegerField(default=0)
    
    def __str__(self):
        return self.clwpn_id + ' ' + self.clwpn_name

    class Meta:
        db_table = 'classWeapon'


class Playercharacter(models.Model):
    pc_name = models.CharField(max_length=20, primary_key = True)
    pc_key = models.IntegerField(default=0)
    pc_class = models.IntegerField(default=0)
    pc_level = models.IntegerField(default=0)
    
    def __str__(self):
        return self.pc_name

    class Meta:
        db_table = 'playerCharacter'


class Spell(models.Model):
    sp_name = models.CharField(max_length=25, primary_key = True)
    sp_slotlevel = models.IntegerField(default=1)
    sp_range = models.IntegerField(default=0) 
    sp_castingtype = models.CharField(max_length=25)
    sp_effect = models.CharField(max_length=25)
    sp_die = models.CharField(max_length=12)

    def __str__(self):
        return self.sp_name

    class Meta:
        db_table = 'spell'


class User(models.Model):
    u_key = models.IntegerField(default=0, primary_key = True)
    u_name = models.CharField(max_length=25)
    
    def __str__(self):
        return self.u_name

    class Meta:
        managed = 'True'
        db_table = 'user'


class Weapon(models.Model):
    wpn_name = models.CharField(max_length=25, primary_key = True)
    wpn_range = models.IntegerField(default=0)
    wpn_damage = models.IntegerField(default=0)

    def __str__(self):
        return self.wpn_name

    class Meta:
        db_table = 'weapon'
